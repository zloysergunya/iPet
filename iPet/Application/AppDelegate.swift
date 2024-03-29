import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
        let keychainService = KeychainService()
        ServiceLocator.shared.add(service: keychainService)

        let authService = AuthService(keychainService: keychainService)
        ServiceLocator.shared.add(service: authService)

        let loggerService = LoggerService()
        LoggerService.setup()
        ServiceLocator.shared.add(service: loggerService)

        let launchService = LaunchService()
        launchService.openModule()
        ServiceLocator.shared.add(service: launchService)

        return true
    }

}
