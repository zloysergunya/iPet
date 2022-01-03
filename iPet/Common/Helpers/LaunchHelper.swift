import UIKit

class LaunchHelper {
    
    static func selectViewController() {
        
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
