// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

internal extension Color {
  // Assets.xcassets
  static var accentColor : Color { Color("AccentColor", bundle: BundleToken.bundle) }
  // Colors.xcassets
  static var backgroundColor : Color { Color("backgroundColor", bundle: BundleToken.bundle) }
  static var endPointColor : Color { Color("endPointColor", bundle: BundleToken.bundle) }
  static var mainTextColor : Color { Color("mainTextColor", bundle: BundleToken.bundle) }
  static var onboardingTextColor : Color { Color("onboardingTextColor", bundle: BundleToken.bundle) }
  static var shadowColor : Color { Color("shadowColor", bundle: BundleToken.bundle) }
  static var startPointColor : Color { Color("startPointColor", bundle: BundleToken.bundle) }
}

internal extension Image {
  // Assets.xcassets
  static var arrow : Image { Image("arrow", bundle: BundleToken.bundle) }
  static var checkmark : Image { Image("checkmark", bundle: BundleToken.bundle) }
  static var countrySelectedIcon : Image { Image("countrySelectedIcon", bundle: BundleToken.bundle) }
  static var firstIntroduction : Image { Image("firstIntroduction", bundle: BundleToken.bundle) }
  static var getStarted : Image { Image("getStarted", bundle: BundleToken.bundle) }
  static var procrasteeImage : Image { Image("procrasteeImage", bundle: BundleToken.bundle) }
  static var reminders : Image { Image("reminders", bundle: BundleToken.bundle) }
  static var secondIntroduction : Image { Image("secondIntroduction", bundle: BundleToken.bundle) }
  static var suggested : Image { Image("suggested", bundle: BundleToken.bundle) }
  static var thirdIntroduction : Image { Image("thirdIntroduction", bundle: BundleToken.bundle) }
  // Colors.xcassets
}

private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
