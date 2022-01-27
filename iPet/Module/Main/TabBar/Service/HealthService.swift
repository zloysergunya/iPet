import UIKit
import HealthKit

protocol HealthServiceInput {
    func requestAccess()
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
    
}

// MARK: - HealthServiceInput
extension HealthService: HealthServiceInput {
    
    func requestAccess() {
        guard HKHealthStore.isHealthDataAvailable() else {
            output?.failureHealthAccessRequest(error: HealthkitSetupError.notAvailableOnDevice)
            
            return
        }

        guard
            let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
            let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
        else {
            output?.failureHealthAccessRequest(error: HealthkitSetupError.dataTypeNotAvailable)
            
            return
        }
        
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth, biologicalSex, height, bodyMass, activeEnergy, HKObjectType.workoutType()]
        
        HKHealthStore().requestAuthorization(toShare: nil, read: healthKitTypesToRead) { [weak self] granted, error in
            if let error = error {
                self?.output?.failureHealthAccessRequest(error: error)
            } else {
                self?.output?.successHealthAccessRequest(granted: granted)
            }
        }

    }
    
}
