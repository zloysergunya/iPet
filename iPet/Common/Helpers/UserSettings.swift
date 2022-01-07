import Foundation

@objc class UserSettings: NSObject {

    static let defaults = UserDefaults.standard

    fileprivate enum Keys: String {
        case token
        case user
    }
    
    static var token: String? {
        get {
            return defaults.string(forKey: Keys.token.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.token.rawValue)
        }
    }
    
    static var user: User? {
        get {
            return try? defaults.get(objectType: User.self, forKey: Keys.user.rawValue)
        }
        set {
            try? defaults.set(object: newValue, forKey: Keys.user.rawValue)
        }
    }
    
    @objc static func clear() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
}
