import Foundation
import UIKit

enum Constants {

    static let appStoreId = ""
    static let bundleIdentifier = Bundle.current.bundleIdentifier ?? "com.abs.ipet"

    static var releaseVersion: String { Bundle.current.releaseVersionNumber ?? "0.0.0" }
    static var buildNumber: String { Bundle.current.buildVersionNumber ?? "0" }
    static var appVersion: String { "\(releaseVersion) (\(buildNumber))" }
    static var deviceModelName: String { UIDevice.modelName.replacingOccurrences(of: " ", with: "_", options: .literal) }
    
    static var userAgent: String? = {
        if let lang = Locale.current.languageCode {

            // {Api version} {platform}/{version}/{build} {language} {device}
            print("userAgent \(iPetAPI.apiVersion) ios/\(Constants.releaseVersion)/\(Constants.buildNumber) \(lang) \(deviceModelName)")
            return "\(iPetAPI.apiVersion) ios/\(Constants.releaseVersion)/\(Constants.buildNumber) \(lang) \(deviceModelName)"
        }

        return nil
    }()
}
