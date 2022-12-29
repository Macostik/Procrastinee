//
//  Environment+Value.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var screenSize: CGSize {
        get { return self[ScreenSizeKey.self] }
        set { self[ScreenSizeKey.self] = newValue }
    }
    var safeAreaInsets: EdgeInsets {
        get { return self[SafeAreaInsetsKey.self] }
        set { self[SafeAreaInsetsKey.self] = newValue }
    }
    var currentUser: User {
        get { return self[CurrentUserKey.self] }
        set { self[CurrentUserKey.self] = newValue }
    }
}
public struct CurrentUserKey: EnvironmentKey {
    public static let defaultValue: User = .empty
}
public struct ScreenSizeKey: EnvironmentKey {
    public static let defaultValue: CGSize = .zero
}
public struct SafeAreaInsetsKey: EnvironmentKey {
    public static let defaultValue = EdgeInsets(top: 0,
                                                leading: 0,
                                                bottom: 0,
                                                trailing: 0)
}
