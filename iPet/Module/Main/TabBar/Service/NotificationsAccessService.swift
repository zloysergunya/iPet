import UIKit
import UserNotifications

protocol NotificationsAccessServiceInput: AnyObject {
    func requestAccess()
}

protocol NotificationsAccessServiceOutput: AnyObject {
    func successNotificationsAccessRequest(granted: Bool)
    func failureNotificationsAccessRequest(error: Error)
}

class NotificationsAccessService: NSObject {
        
    weak var output: NotificationsAccessServiceOutput?
    
}

// MARK: - NotificationsAccessServiceInput
extension NotificationsAccessService: NotificationsAccessServiceInput {
    
    func requestAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                log.error("Notifications requestAuthorization failed: \(error)")
                
                DispatchQueue.main.async {
                    self.output?.failureNotificationsAccessRequest(error: error)
                }
                
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    self.output?.successNotificationsAccessRequest(granted: granted)
                }
            }
        }
    }
    
}
