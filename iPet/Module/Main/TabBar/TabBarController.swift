import UIKit

class TabBarController: UITabBarController {
    
    private let notificationsAccessService = NotificationsAccessService()
    private let healthService = HealthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationsAccessService.output = self
        notificationsAccessService.requestAccess()
        
        healthService.output = self
    }
    
}

// MARK: - NotificationsAccessServiceOutput
extension TabBarController: NotificationsAccessServiceOutput {
    
    func successNotificationsAccessRequest(granted: Bool) {
        print("granted \(granted)")
        healthService.requestAccess()
    }
    
    func failureNotificationsAccessRequest(error: Error) {
        healthService.requestAccess()
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
