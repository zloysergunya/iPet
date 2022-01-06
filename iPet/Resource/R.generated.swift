//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  /// This `R.color` struct is generated, and contains static references to 7 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `background`.
    static let background = Rswift.ColorResource(bundle: R.hostingBundle, name: "background")
    /// Color `blueAccent`.
    static let blueAccent = Rswift.ColorResource(bundle: R.hostingBundle, name: "blueAccent")
    /// Color `grayColor`.
    static let grayColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayColor")
    /// Color `orangeAccent`.
    static let orangeAccent = Rswift.ColorResource(bundle: R.hostingBundle, name: "orangeAccent")
    /// Color `textPrimary`.
    static let textPrimary = Rswift.ColorResource(bundle: R.hostingBundle, name: "textPrimary")
    /// Color `textSecondary`.
    static let textSecondary = Rswift.ColorResource(bundle: R.hostingBundle, name: "textSecondary")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "background", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.background, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "blueAccent", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blueAccent(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blueAccent, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "grayColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func grayColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.grayColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "orangeAccent", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func orangeAccent(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.orangeAccent, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "textPrimary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func textPrimary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.textPrimary, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "textSecondary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func textSecondary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.textSecondary, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "background", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func background(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.background.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "blueAccent", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blueAccent(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blueAccent.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "grayColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func grayColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.grayColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "orangeAccent", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func orangeAccent(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.orangeAccent.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "textPrimary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func textPrimary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.textPrimary.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "textSecondary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func textSecondary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.textSecondary.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.entitlements` struct is generated, and contains static references to 1 properties.
  struct entitlements {
    struct comAppleDeveloperApplesignin {
      static let `default` = infoPlistString(path: ["com.apple.developer.applesignin"], key: "Default") ?? "Default"

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 5 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    /// Resource file `MontserratBold.ttf`.
    static let montserratBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "MontserratBold", pathExtension: "ttf")
    /// Resource file `MontserratMedium.ttf`.
    static let montserratMediumTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "MontserratMedium", pathExtension: "ttf")
    /// Resource file `MontserratRegular.ttf`.
    static let montserratRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "MontserratRegular", pathExtension: "ttf")
    /// Resource file `MontserratSemiBold.ttf`.
    static let montserratSemiBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "MontserratSemiBold", pathExtension: "ttf")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "MontserratBold", withExtension: "ttf")`
    static func montserratBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "MontserratMedium", withExtension: "ttf")`
    static func montserratMediumTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratMediumTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "MontserratRegular", withExtension: "ttf")`
    static func montserratRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "MontserratSemiBold", withExtension: "ttf")`
    static func montserratSemiBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.montserratSemiBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 4 fonts.
  struct font: Rswift.Validatable {
    /// Font `Montserrat-Bold`.
    static let montserratBold = Rswift.FontResource(fontName: "Montserrat-Bold")
    /// Font `Montserrat-Medium`.
    static let montserratMedium = Rswift.FontResource(fontName: "Montserrat-Medium")
    /// Font `Montserrat-Regular`.
    static let montserratRegular = Rswift.FontResource(fontName: "Montserrat-Regular")
    /// Font `Montserrat-SemiBold`.
    static let montserratSemiBold = Rswift.FontResource(fontName: "Montserrat-SemiBold")

    /// `UIFont(name: "Montserrat-Bold", size: ...)`
    static func montserratBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratBold, size: size)
    }

    /// `UIFont(name: "Montserrat-Medium", size: ...)`
    static func montserratMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratMedium, size: size)
    }

    /// `UIFont(name: "Montserrat-Regular", size: ...)`
    static func montserratRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratRegular, size: size)
    }

    /// `UIFont(name: "Montserrat-SemiBold", size: ...)`
    static func montserratSemiBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: montserratSemiBold, size: size)
    }

    static func validate() throws {
      if R.font.montserratBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-Bold' could not be loaded, is 'MontserratBold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.montserratMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-Medium' could not be loaded, is 'MontserratMedium.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.montserratRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-Regular' could not be loaded, is 'MontserratRegular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.montserratSemiBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Montserrat-SemiBold' could not be loaded, is 'MontserratSemiBold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 6 images.
  struct image {
    /// Image `appleLogo`.
    static let appleLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "appleLogo")
    /// Image `foxMascote`.
    static let foxMascote = Rswift.ImageResource(bundle: R.hostingBundle, name: "foxMascote")
    /// Image `googleLogo`.
    static let googleLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "googleLogo")
    /// Image `petPageContollStep1`.
    static let petPageContollStep1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "petPageContollStep1")
    /// Image `petPageContollStep2`.
    static let petPageContollStep2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "petPageContollStep2")
    /// Image `registerAddPhoto`.
    static let registerAddPhoto = Rswift.ImageResource(bundle: R.hostingBundle, name: "registerAddPhoto")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "appleLogo", bundle: ..., traitCollection: ...)`
    static func appleLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.appleLogo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "foxMascote", bundle: ..., traitCollection: ...)`
    static func foxMascote(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.foxMascote, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "googleLogo", bundle: ..., traitCollection: ...)`
    static func googleLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.googleLogo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "petPageContollStep1", bundle: ..., traitCollection: ...)`
    static func petPageContollStep1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.petPageContollStep1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "petPageContollStep2", bundle: ..., traitCollection: ...)`
    static func petPageContollStep2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.petPageContollStep2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "registerAddPhoto", bundle: ..., traitCollection: ...)`
    static func registerAddPhoto(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.registerAddPhoto, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      // There are no resources to validate
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R {
  fileprivate init() {}
}
