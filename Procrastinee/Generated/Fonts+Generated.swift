// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

extension Font {
  public static func annieUseYourTelescope(_ style: AnnieUseYourTelescopeStyle, fixedSize: CGFloat) -> Font {
    return Font.custom(style.rawValue, fixedSize: fixedSize)
  }

  public static func annieUseYourTelescope(_ style: AnnieUseYourTelescopeStyle, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
    return Font.custom(style.rawValue, size: size, relativeTo: textStyle)
  }

  public enum AnnieUseYourTelescopeStyle: String {
    case regular = "AnnieUseYourTelescope-Regular"
  }
}
