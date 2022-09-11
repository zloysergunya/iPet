import UIKit
import SPPermissions

class TabBarController: UITabBarController {
    
    private let healthService = HealthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthService.output = self
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !SPPermissions.Permission.notification.authorized {
            let permissions: [SPPermissions.Permission] = [.notification, .health]
            let permissionsController = SPPermissions.list(permissions)
            permissionsController.allowSwipeDismiss = false
            permissionsController.delegate = self
            permissionsController.present(on: self)
        }
    }
    
    private func configure() {
        let generalViewController = GeneralViewController()
        generalViewController.tabBarItem.image = R.image.tabBarActivity()
        generalViewController.tabBarItem.title = "Активность"
        
        viewControllers = [UINavigationController(rootViewController: generalViewController),
//                           UINavigationController(rootViewController: FriendProfileViewController(user: UserSettings.user!)),
                           UINavigationController(rootViewController: FollowersListViewController(type: .following)),
        ]
        
        tabBar.shadowImage = nil
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = R.color.mainGray()
    }
    
}

// MARK: - SPPermissionsDelegate
extension TabBarController: SPPermissionsDelegate {
    
    func didAllowPermission(_ permission: SPPermissions.Permission) {
        if permission == .notification {
            healthService.requestAccess()
        }
    }
    
    func didDeniedPermission(_ permission: SPPermissions.Permission) {
        if permission == .notification {
            healthService.requestAccess()
        }
    }
    
}

// MARK: - HealthServiceOutput
extension TabBarController: HealthServiceOutput {
    
    func successHealthAccessRequest(granted: Bool) {
        print("granted \(granted)")
    }
    
    func failureHealthAccessRequest(error: Error) {
        
    }
    
}
