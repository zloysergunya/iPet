import UIKit
import SPPermissions

class TabBarController: UITabBarController {
    
    private let healthService = HealthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthService.output = self
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
