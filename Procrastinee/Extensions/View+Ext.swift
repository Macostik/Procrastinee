//
//  View+Ext.swift
//  Procrastinee
//
//  Created by Macostik on 11.12.2022.
//

import Foundation
import SwiftUI
// swiftlint:disable line_length
extension View {
    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value,
                                                       completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value,
                                                            completion: completion))
    }
}
