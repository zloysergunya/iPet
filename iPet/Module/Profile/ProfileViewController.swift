import UIKit

class ProfileViewController: ViewController<ProfileView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget()
        languageTapRecognize()
        recallTapRecognize()
        socialNetworksTapRecognize()
        exitTapRecognize()
    }
    
    private func languageTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(setLanguageTapGesture))
        mainView.profileContentView.appSettingsContentView.languageSetting.addGestureRecognizer(tapRecognizer)
    }
    
    private func recallTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(recallTapGesture))
        mainView.profileContentView.appSettingsContentView.recallView.addGestureRecognizer(tapRecognizer)
    }
    
    private func socialNetworksTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(socialNetworksTapGesture))
        mainView.profileContentView.appSettingsContentView.socialNetworksView.addGestureRecognizer(tapRecognizer)
    }
    
    private func exitTapRecognize() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(exitTapGesture))
        mainView.profileContentView.exitAccountContainerView.exitAccountView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func setLanguageTapGesture() {
        print("Click language setting")
    }
    
    @objc private func recallTapGesture() {
        print("Click recall")
    }
    
    @objc private func socialNetworksTapGesture() {
        print("Click socialNetworks")
    }
    
    @objc private func exitTapGesture() {
        print("Click exit")
    }
    
    @objc private func closedProfileSwitchPressed() {
        print("Close profile switch pressed")
    }
    
    @objc private func notificationSwitchPressed() {
        print("Notification switch pressed")
    }
    
    @objc private func editProfileButtonPressed() {
        print("Edit profile")
    }
    
    private func addTarget() {
            mainView.profileContentView.appSettingsContentView.closedProfileView.settingSwitch.addTarget(
                self,
                action: #selector(closedProfileSwitchPressed),
                for: .touchUpInside)
            mainView.profileContentView.appSettingsContentView.notificationsView.settingSwitch.addTarget(
                self,
                action: #selector(notificationSwitchPressed),
                for: .touchUpInside)
            mainView.profileContentView.headerProfileView.editProfileButton.addTarget(
                self,
                action: #selector(editProfileButtonPressed),
                for: .touchUpInside)
    }
    
}

