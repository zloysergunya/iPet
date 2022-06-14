import UIKit
import Atributika

class GeneralViewController: ViewController<GeneralView> {
    
    private let provider = GeneralProvider()
    private let healthService: HealthService? = ServiceLocator.getService()
    
    private var petAnimation: PetAnimation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.animatedPetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnPet)))
        
        healthService?.output = self
        healthService?.requestAccess()
        
        load()
        
        if let stats = UserSettings.stats {
            DispatchQueue.main.async { [weak self] in
                self?.configure(with: stats)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func load() {
        updateGeneralInfo()
        updateLvlAwards()
        updatePet()
        updateConfig()
        downloadPets()
    }
    
    private func updateGeneralInfo() {
        provider.general { [weak self] result in
            switch result {
            case .success(let stats):
                UserSettings.stats = stats
                self?.configure(with: stats)
                
            case .failure(let error): break
            }
        }
    }
    
    private func downloadPets() {
        provider.downloadPets { [weak self] result in
            switch result {
            case .success(let petAnimations):
                UserSettings.petAnimations = petAnimations
                self?.provider.cacheAnimations(petAnimations)
                self?.updatePet()
                
            case .failure(let error): break
            }
        }
    }
    
    private func updateLvlAwards() {
        provider.generalLvlAwards { [weak self] result in
            
        }
    }
    
    private func updateConfig() {
        provider.updateConfig { result in
            switch result {
            case .success: break
            case .failure(let error): break
            }
        }
    }
    
    private func syncUserActivity() {
        let lastDate = UserSettings.lastSendActivityDate?.add(.day, value: -7) ?? Date()
        let toDate = Date()
        
        Date.dates(from: lastDate, to: toDate).forEach { date in
            healthService?.getUserActivity(date: date, completion: nil)
        }
    }
    
    private func configure(with stats: Stats) {
        let user = UserSettings.user
        
        mainView.shopButton.setTitle("\(user?.coins ?? 0)", for: .normal)
        mainView.petNameLabel.text = user?.pet?.name
        mainView.petLevelLabel.text = "Уровень: \(user?.lvlActivity ?? 1)"
        
        if let avatarURL = user?.avatarURL, let imageView = mainView.profileButton.imageView {
            ImageLoader.setImage(url: iPetAPI.serverUrl + avatarURL,
                                 imageView: imageView,
                                 placeholderImage: R.image.photoPlaceholder())
        }
        
        if let activeStatus = user?.pet?.activeStatus, let state = ActiveStatus(rawValue: activeStatus) {
            mainView.petStatusLabel.text = state.description
            mainView.radialGradientView.colors = state.colors
        }
        
        if let petObesityLevel = user?.pet?.petObesityLevel, let state = PetState(rawValue: petObesityLevel) {
            let grayStyle = Style("gray").foregroundColor(.init(hex: 0x5A5856))
            mainView.petStateLabel.attributedText = "<gray>состояние:</gray> \(state.description)".style(tags: grayStyle).attributedString
        }
        
        mainView.achivmentsView.drawFilledLayer(completed: 3)
        
        updateProgress(for: stats)
    }

    private func updateProgress(for stats: Stats) {
        mainView.mainActivityProgressView.stepsProgressView.draw(with: "\(stats.steps)",
                                                                 subtitle: "Шагов\nсегодня",
                                                                 currentValue: CGFloat(stats.steps),
                                                                 maxValue: CGFloat(stats.stepsGoal))
        let percent = (stats.steps / (stats.stepsGoal + 1)) * 100
        mainView.mainActivityProgressView.goalProgressView.draw(with: "\(percent)%",
                                                                subtitle: "Выполнено",
                                                                currentValue: CGFloat(percent))
        mainView.mainActivityProgressView.activityProgressView.draw(with: "\(stats.activityMinutes)",
                                                                    subtitle: "Активность",
                                                                    currentValue: CGFloat(stats.activityMinutes),
                                                                    maxValue: 1000.0)
    }
    
    @objc private func updatePet() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        guard let petAnimation = self.petAnimation ?? UserSettings.petAnimations?.first(where: { $0.id == UserSettings.user?.pet?.pet.id }) else {
            return
        }

        self.petAnimation = petAnimation

        let availableAnimations = [petAnimation.animations.base,
                                   petAnimation.animations.blink,
                                   petAnimation.animations.happy,
                                   petAnimation.animations.leftRight,
                                   petAnimation.animations.scratch,
                                   petAnimation.animations.tap,
                                   petAnimation.animations.yawn,
                                   petAnimation.animations.heart,
                                   petAnimation.animations.sleeping,
                                   petAnimation.animations.thinking,
                                   petAnimation.animations.tears,
                                   petAnimation.animations.moveTears].compactMap({ $0 })

        let index = Int.random(in: 0..<availableAnimations.count)
        if let url = URL(string: availableAnimations[index].replacingOccurrences(of: "pet_state", with: "\(petAnimation.state)")) {
            mainView.animatedPetView.setAnimation(url)
        }
        
        perform(#selector(updatePet), with: nil, afterDelay: 15)
    }
    
    @objc private func tapOnPet() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if let state = petAnimation?.state,
           let tapAnimation = petAnimation?.animations.tap.replacingOccurrences(of: "pet_state", with: "\(state)"),
           let url = URL(string: tapAnimation) {
           
            mainView.animatedPetView.setAnimation(url, loopMode: .playOnce) { [weak self] _ in
                self?.updatePet()
            }
        }
    }
    
}

// MARK: - HealthServiceOutput
extension GeneralViewController: HealthServiceOutput {
    
    func successHealthAccessRequest(granted: Bool) {
        if granted {
            syncUserActivity()
        }
    }
    
    func failureHealthAccessRequest(error: Error) {
        if let error = error as? ModelError {
//            showError(text: error.localizedDescription)
        } else {
//            showError(text: error.localizedDescription)
        }
    }
    
}