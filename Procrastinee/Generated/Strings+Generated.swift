// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Onboarding {
    /// Your Account is created Successfully
    public static let accountCreateSuccess = L10n.tr("Localizable", "onboarding.accountCreateSuccess")
    /// Already subscriber?
    public static let alreadySubscribe = L10n.tr("Localizable", "onboarding.alreadySubscribe")
    /// Also, in this app, you will meet a community of people who are on the same page as you, who are working hard to become the most productive version of them selfs.
    public static let also = L10n.tr("Localizable", "onboarding.also")
    /// and, most of all - 
    public static let andMost = L10n.tr("Localizable", "onboarding.andMost")
    /// 1,66 USD / week
    public static let averagePriceOfMonth = L10n.tr("Localizable", "onboarding.averagePriceOfMonth")
    /// 4,99 USD / week
    public static let averagePriceOfWeek = L10n.tr("Localizable", "onboarding.averagePriceOfWeek")
    /// 0,41 USD / week
    public static let averagePriceOfYear = L10n.tr("Localizable", "onboarding.averagePriceOfYear")
    /// & become more successful in your daily life. Here, you will find all the tools to help you stay 
    public static let becomeMoreSuccessful = L10n.tr("Localizable", "onboarding.becomeMoreSuccessful")
    /// Choose your plan
    public static let chooseYourPlan = L10n.tr("Localizable", "onboarding.chooseYourPlan")
    /// Continue
    public static let `continue` = L10n.tr("Localizable", "onboarding.continue")
    /// CREATE
    public static let create = L10n.tr("Localizable", "onboarding.create")
    /// Creating a profile...
    public static let creatingProfile = L10n.tr("Localizable", "onboarding.creatingProfile")
    /// For better experience, 
    public static let forBetter = L10n.tr("Localizable", "onboarding.forBetter")
    /// Get Started
    public static let getStarted = L10n.tr("Localizable", "onboarding.getStarted")
    /// Hey! We’re really happy to meet you. Before you begin this journey of 
    public static let hey = L10n.tr("Localizable", "onboarding.hey")
    /// Keep you on track with small reminders?
    public static let keepYourTrack = L10n.tr("Localizable", "onboarding.keepYourTrack")
    /// motivated. 
    public static let motivated = L10n.tr("Localizable", "onboarding.motivated")
    /// Nickname...
    public static let nickname = L10n.tr("Localizable", "onboarding.nickname")
    /// 1 Week
    ///  Plan
    public static let oneWeek = L10n.tr("Localizable", "onboarding.oneWeek")
    /// 4,99 USD
    ///  for week
    public static let oneWeekPrice = L10n.tr("Localizable", "onboarding.oneWeekPrice")
    /// 1 Year
    ///  Plan
    public static let oneYear = L10n.tr("Localizable", "onboarding.oneYear")
    /// 29,99 USD
    ///  for year
    public static let oneYearPrice = L10n.tr("Localizable", "onboarding.oneYearPrice")
    /// or 
    public static let or = L10n.tr("Localizable", "onboarding.or")
    /// productive, concentrated 
    public static let proactive = L10n.tr("Localizable", "onboarding.proactive")
    /// You will be able not to just set the tasks but also you will complete all of them by the end of the day. You will no longer scold yourself for not finishing the set tasks you had to do because you already completed them.
    public static let secondIntroduction = L10n.tr("Localizable", "onboarding.secondIntroduction")
    /// Set your nickname and country.
    public static let setYourName = L10n.tr("Localizable", "onboarding.setYourName")
    /// stopping procrastinating, 
    public static let stoping = L10n.tr("Localizable", "onboarding.stoping")
    /// stop procrastinating 
    public static let stopProcrastinating = L10n.tr("Localizable", "onboarding.stopProcrastinating")
    /// This app will help you to 
    public static let thirdIntroduction = L10n.tr("Localizable", "onboarding.thirdIntroduction")
    /// 12 Weeks
    ///  Plan
    public static let threeMonth = L10n.tr("Localizable", "onboarding.threeMonth")
    /// 19,99 USD
    ///  for 12 weeks
    public static let threeMonthPrice = L10n.tr("Localizable", "onboarding.threeMonthPrice")
    /// to create your profile
    public static let toCreateProfile = L10n.tr("Localizable", "onboarding.toCreateProfile")
    /// TRY 3 DAYS FREE
    public static let tryFree = L10n.tr("Localizable", "onboarding.tryFree")
    /// turn audio on 
    public static let turnAudioOn = L10n.tr("Localizable", "onboarding.turnAudioOn")
    /// use headphones.
    public static let useHeadphones = L10n.tr("Localizable", "onboarding.useHeadphones")
    /// Use reminders to achieve best results
    public static let useReminders = L10n.tr("Localizable", "onboarding.useReminders")
    /// we just want to tell you what exactly you will achieve by completely killing all your procrastinating nature.
    public static let weJustWant = L10n.tr("Localizable", "onboarding.weJustWant")
    /// Yes, please
    public static let yesPlease = L10n.tr("Localizable", "onboarding.yesPlease")
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
