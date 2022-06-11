import Foundation

@objc class UserSettings: NSObject {

    static let defaults = UserDefaults.standard
    
    static var token: String? {
        get {
            return defaults.string(forKey: #function)
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var user: User? {
        get {
            return try? defaults.get(objectType: User.self, forKey: #function)
        }
        set {
            try? defaults.set(object: newValue, forKey: #function)
        }
    }
    
    static var pets: [Pet]? {
        get {
            return try? defaults.get(objectType: [Pet].self, forKey: #function)
        }
        set {
            try? defaults.set(object: newValue, forKey: #function)
        }
    }
    
    static var petAnimations: [PetAnimation]? {
        get {
            return try? defaults.get(objectType: [PetAnimation].self, forKey: #function)
        }
        set {
            try? defaults.set(object: newValue, forKey: #function)
        }
    }
    
    static var userReady: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var isLaunchedBefore: Bool {
        get {
            return defaults.bool(forKey: #function)
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var lastSendActivityDate: Date? {
        get {
            return defaults.object(forKey: #function) as? Date
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var stats: Stats? {
        get {
            return try? defaults.get(objectType: Stats.self, forKey: #function)
        }
        set {
            try? defaults.set(object: newValue, forKey: #function)
        }
    }
    
    @objc static func clear() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
}
