//
//  KeyboardHandler.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import Foundation
import Combine
import UIKit

class KeyboardHandler: ObservableObject {
    @Published private (set) var height: CGFloat = 0 {
        willSet {
            isShown = newValue == 0
        }
    }
    @Published private (set) var isShown: Bool = false
    private var cancel: AnyCancellable?
    private var keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { value in
           return (value.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
        }
    private var keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .compactMap { _ in
            return CGFloat.zero
        }
    init() {
        cancel = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .assign(to: \.height, on: self)
    }
}
