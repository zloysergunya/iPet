import UIKit
import HealthKit

protocol HealthServiceInput {
    func requestAccess()
    func updateUserActivity(date: Date)
}

protocol HealthServiceOutput: AnyObject {
    func successHealthAccessRequest(granted: Bool)
    func failureHealthAccessRequest(error: Error)
}

enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
}

class HealthService: NSObject {
    
    weak var output: HealthServiceOutput?
    
    private let provider = HealthServiceProvider()
    private let healthStore = HKHealthStore()
    private let activeEnergyObject = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
    private let stepsCountObject = HKObjectType.quantityType(forIdentifier: .stepCount)
    private let distanceObject = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
    
    private var authService: AuthService? = ServiceLocator.getService()
    
    override init() {
        super.init()
                
        if let stepsQuantityType = stepsCountObject,
           let distanceQuantityType = distanceObject,
           let activeEnergyObject = activeEnergyObject {
            setupBackgroundDeliveryFor(types: [stepsQuantityType, distanceQuantityType, activeEnergyObject])
        }
    }
    
    private func setupBackgroundDeliveryFor(types: [HKObjectType]) {
        for type in types {
            guard let sampleType = type as? HKSampleType else {
                log.error("\(type) is not an HKSampleType")
                continue
            }
            
            let query = HKObserverQuery(sampleType: sampleType, predicate: nil) { [weak self] _, completionHandler,_ in
                self?.updateUserActivity(date: Date())
                completionHandler()
            }
            
            healthStore.execute(query)
            healthStore.enableBackgroundDelivery(for: type, frequency: .immediate) { [weak self] success, error in
                if success {
                    log.verbose("\(type) Delivery enabled")
                } else if let error = error {
                    log.error("EnableBackgroundDelivery for type \(type) error: \(error.localizedDescription)")
                    self?.output?.failureHealthAccessRequest(error: ModelError(text: "EnableBackgroundDelivery for type \(type) error: \(error.localizedDescription)"))
                }
            }
        }
    }
    
    private func activity(from: Date, to: Date, completion: ((Int, Int, Double) -> Void)?) {
        var calories = 0
        var stepsCount = 0
        var distance = 0.0
        
        guard let stepsQuantityType = stepsCountObject,
              let distanceQuantityType = distanceObject,
              let activeEnergyQuantityType = activeEnergyObject
        else {
            completion?(calories, stepsCount, distance)
            return
        }
        
        let dispatchGroup = DispatchGroup()
        
        let predicate = HKObserverQuery.predicateForSamples(withStart: from,
                                                            end: to,
                                                            options: .strictStartDate)
        
        dispatchGroup.enter()
        let caloriesQuery = HKStatisticsQuery(quantityType: activeEnergyQuantityType,
                                           quantitySamplePredicate: predicate,
                                           options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                dispatchGroup.leave()
                return
            }
            
            calories = Int(sum.doubleValue(for: HKUnit.kilocalorie()))
            
            dispatchGroup.leave()
        }
        healthStore.execute(caloriesQuery)
        
        dispatchGroup.enter()
        let stepsQuery = HKStatisticsQuery(quantityType: stepsQuantityType,
                                           quantitySamplePredicate: predicate,
                                           options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                dispatchGroup.leave()
                return
            }
            
            stepsCount = Int(sum.doubleValue(for: HKUnit.count()))
            
            dispatchGroup.leave()
        }
        healthStore.execute(stepsQuery)
        
        dispatchGroup.enter()
        let distanceQuery = HKStatisticsQuery(quantityType: distanceQuantityType,
                                              quantitySamplePredicate: predicate,
                                              options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                dispatchGroup.leave()
                return
            }
            
            distance = sum.doubleValue(for: HKUnit.meterUnit(with: .kilo))
            
            dispatchGroup.leave()
        }
        healthStore.execute(distanceQuery)
        
        dispatchGroup.notify(queue: .main) {
            completion?(calories, stepsCount, distance)
        }
    }
    
    private func sendUserActivity(statsPostRequest: [StatsPostRequest]) {
        guard authService?.authStatus == .authorized else {
            return
        }
        
        provider.sendUserActivity(statsPostRequest: statsPostRequest) { [weak self] result in
            switch result {
            case .success:
                UserSettings.lastSendActivityDate = Date()
                
            case .failure(let error):
                self?.output?.failureHealthAccessRequest(error: error)
            }
        }
    }
    
    private func hoursInDayFor(date: Date) -> [Date] {
        var dates: [Date] = []
        let hoursInDayRange = Calendar.current.range(of: .hour, in: .day, for: date)
        
        if let hoursInDayRange = hoursInDayRange {
            let year = Calendar.current.component(.year, from: date)
            let month = Calendar.current.component(.month, from: date)
            let weekOfMonth = Calendar.current.component(.weekOfMonth, from: date)
            let day = Calendar.current.component(.day, from: date)
            
            for hourOfDay in (hoursInDayRange.lowerBound..<hoursInDayRange.upperBound) {
                let components = DateComponents(year: year, month: month, day: day, hour: hourOfDay, weekOfMonth: weekOfMonth)
                guard let date = Calendar.current.date(from: components) else { continue }
                dates.append(date)
            }
        }
        
        return dates
    }
    
}

// MARK: - HealthServiceInput
extension HealthService: HealthServiceInput {
    
    func requestAccess() {
        guard HKHealthStore.isHealthDataAvailable() else {
            log.error(log.error("NotAvailableOnDevice error: \(HealthkitSetupError.dataTypeNotAvailable)"))
            output?.failureHealthAccessRequest(error: ModelError.HKHealthStoreNotAvailableOnDevice)
            
            return
        }
        
        guard let stepCount = stepsCountObject, let distance = distanceObject, let activeEnergy = activeEnergyObject else {
            log.error("DataTypeNotAvailable error: \(HealthkitSetupError.dataTypeNotAvailable)")
            output?.failureHealthAccessRequest(error: ModelError.HKHealthStoreDataTypeNotAvailable)
            
            return
        }
        
        let healthKitTypesToRead: Set<HKObjectType> = [stepCount, distance, activeEnergy]
        
        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { [weak self] granted, error in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    log.error("RequestAuthorization error: \(error.localizedDescription)")
                    self.output?.failureHealthAccessRequest(error: ModelError.HKHealthStoreRequestAuthorization)
                } else {
                    self.output?.successHealthAccessRequest(granted: granted)
                }
            }
            
        }
        
    }
    
    func updateUserActivity(date: Date) {
        let hours = hoursInDayFor(date: Calendar.current.startOfDay(for: date))
        var activities: [StatsPostRequest] = []
        
        let dispatchGroup = DispatchGroup()
        
        for i in 0..<hours.count - 1 {
            dispatchGroup.enter()
            activity(from: hours[i], to: hours[i + 1]) { calories, stepsCount, distance in
                activities.append(.init(date: Int64(hours[i].timeIntervalSince1970),
                                        calories: calories,
                                        kilometers: distance,
                                        steps: stepsCount))
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.sendUserActivity(statsPostRequest: activities)
        }
    }
    
}
