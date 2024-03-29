import UIKit

class ProfileSettingsViewController: ViewController<ProfileSettingsView> {

    private let locale = NSLocale.autoupdatingCurrent
    private let provider = ProfileSettingsProvider()
    
    @Autowired
    private var authService: AuthService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let languageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setLanguageTapGesture))
        mainView.profileSettingsContentView.appSettingsContentView.languageSetting.addGestureRecognizer(languageTapRecognizer)

        let recallTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(recallTapGesture))
        mainView.profileSettingsContentView.appSettingsContentView.recallView.addGestureRecognizer(recallTapRecognizer)

        let socialNetworksTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(socialNetworksTapGesture))
        mainView.profileSettingsContentView.appSettingsContentView.socialNetworksView.addGestureRecognizer(socialNetworksTapRecognizer)

        let exitAccountTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(exitTapGesture))
        mainView.profileSettingsContentView.exitAccountContainerView.exitAccountView.addGestureRecognizer(exitAccountTapRecognizer)
        
        mainView.profileSettingsContentView.headerProfileSettingsView.editProfileButton.addTarget(self, action: #selector(editProfileButtonPressed), for: .touchUpInside)
        mainView.profileSettingsContentView.appSettingsContentView.notificationsView.switcher.addTarget(self, action: #selector(notificationSwitchPressed), for: .touchUpInside)
        mainView.profileSettingsContentView.appSettingsContentView.closedProfileView.switcher.addTarget(self, action: #selector(closedProfileSwitchPressed), for: .touchUpInside)

        appLanguage()
        uploadUserPhoto()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateMe()
    }
    
    private func updateMe() {
        provider.updateMe { [weak self] result in
            switch result {
            case .success(let user):
                UserSettings.user = user
                self?.configure()
            case .failure(let error):
                error.localizedDescription
                break
            }
        }
    }
    
    private func configure() {
        let user = UserSettings.user
        
        ImageLoader.setImage(url: user?.avatarURL, imageView: mainView.profileSettingsContentView.headerProfileSettingsView.imageView)
        
        mainView.profileSettingsContentView.headerProfileSettingsView.imageView.image = UIImage(named: "\(user?.avatarURL ?? "")") ?? UIImage(named: "foxMascote")
        mainView.profileSettingsContentView.headerProfileSettingsView.nameLabel.text = "\(user?.name ?? "Иван")"
        mainView.profileSettingsContentView.headerProfileSettingsView.userNameLabel.text = "\(user?.username ?? "coala")"
        mainView.profileSettingsContentView.headerProfileSettingsView.petNameLabel.text = "\(user?.pet?.name ?? "Пуфик")"
        mainView.profileSettingsContentView.userSettingsContentView.dailyGoalMetricView.metricLabel.text = "\(user?.stepsCount ?? 0)"
        mainView.profileSettingsContentView.userSettingsContentView.ageMetricView.metricLabel.text = "\(user?.age ?? 0)"
        mainView.profileSettingsContentView.userSettingsContentView.heightMetricView.metricLabel.text = "\(user?.height ?? 0)"
        mainView.profileSettingsContentView.userSettingsContentView.weightMetricView.metricLabel.text = "\(user?.weight ?? 0)"
        mainView.profileSettingsContentView.userSettingsContentView.sexView.genderImage.image = user?.gender == "male"
        ? R.image.manGender()
        : R.image.femaleGender()
        mainView.profileSettingsContentView.distanceNumberLabel.text = "\(user?.totalDistance ?? 0)"
    }
    
    @objc private func setLanguageTapGesture() { 
        showAlert()
    }
    
    @objc private func recallTapGesture() {
        
    }
    
    @objc private func socialNetworksTapGesture() {
        
    }
    
    @objc private func exitTapGesture() {
        authService?.deauthorize()
    }
    
    @objc private func closedProfileSwitchPressed() {
        
    }
    
    @objc private func notificationSwitchPressed() {
        
    }
    
    @objc private func editProfileButtonPressed() {
        let profileSettingVC = UserSettingsViewController()
        profileSettingVC.modalTransitionStyle = .flipHorizontal
        profileSettingVC.modalPresentationStyle = .overFullScreen
        present(profileSettingVC, animated: true)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Чтобы изменить язык приложения, перейдите в настройки устройства.", message: "", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) -> Void in
            let settingsURL = URL(string: UIApplication.openSettingsURLString)
            UIApplication.shared.open(settingsURL!) { (success) in
                print("Settings opened: \(success)")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        present(alertController, animated: true)
    }
    
    private func appLanguage() {
        guard let code = locale.languageCode else { return }
        let language = locale.localizedString(forLanguageCode: code)
        mainView.profileSettingsContentView.appSettingsContentView.languageSetting.propertyLabel.text = language?.capitalizingFirstLetter()
    }
    
    private func uploadUserPhoto() {
        guard mainView.profileSettingsContentView.headerProfileSettingsView.imageView.image != nil else {
            return
        }
    }
    
}
