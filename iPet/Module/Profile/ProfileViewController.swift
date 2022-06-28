import UIKit

class ProfileViewController: ViewController<ProfileView> {

    private let locale = NSLocale.autoupdatingCurrent
    private let provider = ProfileProvider()
    
    @Autowired
    private var authService: AuthService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let languageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setLanguageTapGesture))
        mainView.profileContentView.appSettingsContentView.languageSetting.addGestureRecognizer(languageTapRecognizer)

        let recallTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(recallTapGesture))
        mainView.profileContentView.appSettingsContentView.recallView.addGestureRecognizer(recallTapRecognizer)

        let socialNetworksTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(socialNetworksTapGesture))
        mainView.profileContentView.appSettingsContentView.socialNetworksView.addGestureRecognizer(socialNetworksTapRecognizer)

        let exitAccountTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(exitTapGesture))
        mainView.profileContentView.exitAccountContainerView.exitAccountView.addGestureRecognizer(exitAccountTapRecognizer)
        
        mainView.profileContentView.appSettingsContentView.closedProfileView.switcher.addTarget(self, action: #selector(closedProfileSwitchPressed), for: .touchUpInside)
        mainView.profileContentView.appSettingsContentView.notificationsView.switcher.addTarget(self, action: #selector(notificationSwitchPressed), for: .touchUpInside)
        mainView.profileContentView.headerProfileView.editProfileButton.addTarget(self, action: #selector(editProfileButtonPressed), for: .touchUpInside)

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
                
            case .failure(let error): break
            }
        }
    }
    
    private func configure() {
        let user = UserSettings.user
        
        mainView.profileContentView.headerProfileView.nameLabel.text = user?.name
        mainView.profileContentView.headerProfileView.userNameLabel.text = user?.username
        mainView.profileContentView.headerProfileView.petNameLabel.text = user?.pet?.name
        ImageLoader.setImage(url: user?.avatarURL, imageView: mainView.profileContentView.headerProfileView.imageView)
        
        mainView.profileContentView.userSettingsContentView.dailyGoalMetricView.metricLabel.text = "\(user?.stepsCount ?? 0)"
        mainView.profileContentView.userSettingsContentView.ageMetricView.metricLabel.text = "\(user?.age ?? 0)"
        mainView.profileContentView.userSettingsContentView.heightMetricView.metricLabel.text = "\(user?.height ?? 0)"
        mainView.profileContentView.userSettingsContentView.weightMetricView.metricLabel.text = "\(user?.weight ?? 0)"
        if user?.gender == "male" {
            mainView.profileContentView.userSettingsContentView.sexView.genderImage.image = R.image.manGender()
        } else {
            mainView.profileContentView.userSettingsContentView.sexView.genderImage.image = R.image.foxMascote()
        }
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
        let profileSettingVC = ProfileSettingsViewController()
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
        mainView.profileContentView.appSettingsContentView.languageSetting.propertyLabel.text = language?.capitalizingFirstLetter()
    }
    
    private func uploadUserPhoto() {
        guard mainView.profileContentView.headerProfileView.imageView.image != nil else {
            return
        }
    }
}
