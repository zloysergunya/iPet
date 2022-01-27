import Foundation

enum Constants {

    static let appStoreId = ""
    static let bundleIdentifier = Bundle.current.bundleIdentifier ?? "com.abs.ipet"

    static var releaseVersion: String { Bundle.current.releaseVersionNumber ?? "0.0.0" }
    static var buildNumber: String { Bundle.current.buildVersionNumber ?? "0" }
    static var appVersion: String { "\(releaseVersion)b\(buildNumber)" }
    
}
