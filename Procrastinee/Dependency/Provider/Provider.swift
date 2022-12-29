//
//  Provider.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation

typealias ProviderType = NotificationProvider & FirebaseProvider
struct Provider: ProviderType {
    var notificationService: NotificationInteractor = {
        NotificationService()
    }()
    var firebaseService: FirebaseInteractor = {
        FirebaseService()
    }()
}
