import UIKit

class LaunchHelper {
    
    static func selectViewController() {
        iPetAPI.customHeaders["X-Token"] = UserSettings.token
        
        let navigationController: UINavigationController
        
        navigationController = SwipeNavigationController(rootViewController: OnboardingViewController())
        navigationController.setNavigationBarHidden(true, animated: false)
        
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
    }
    
    static func logout() {
        DispatchQueue.main.async {
            LaunchHelper.selectViewController()
        }
    }
    
}
