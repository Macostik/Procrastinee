// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

internal extension Color {
  // Assets.xcassets
  static var accentColor : Color { Color("AccentColor", bundle: BundleToken.bundle) }
  // Colors.xcassets
  static var endPointColor : Color { Color("endPointColor", bundle: BundleToken.bundle) }
  static var mainTextColor : Color { Color("mainTextColor", bundle: BundleToken.bundle) }
  static var startPointColor : Color { Color("startPointColor", bundle: BundleToken.bundle) }
}

internal extension Image {
  // Assets.xcassets
  static var getStarted : Image { Image("getStarted", bundle: BundleToken.bundle) }
  static var logoImage : Image { Image("logoImage", bundle: BundleToken.bundle) }
  static var rocrastinee : Image { Image("rocrastinee", bundle: BundleToken.bundle) }
  // Colors.xcassets
}

private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
