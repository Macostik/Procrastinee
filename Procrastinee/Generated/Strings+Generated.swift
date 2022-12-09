// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Onboarding {
    /// For better experience, 
    public static let forBetter = L10n.tr("Localizable", "onboarding.forBetter")
    /// Get Started
    public static let getStarted = L10n.tr("Localizable", "onboarding.getStarted")
    /// Hey! We’re really happy to meet you.
    /// Before you begin this journey of stopping procrastinating, we just want to tell you what exactly you will achieve by completely killing all your procrastinating nature.
    public static let hey = L10n.tr("Localizable", "onboarding.hey")
    /// or 
    public static let or = L10n.tr("Localizable", "onboarding.or")
    /// turn audio on 
    public static let turnAudioOn = L10n.tr("Localizable", "onboarding.turnAudioOn")
    /// use headphones.
    public static let useHeadphones = L10n.tr("Localizable", "onboarding.useHeadphones")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
