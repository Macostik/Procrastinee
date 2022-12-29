//
//  NotificationProvider.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation
import UserNotificationsUI
import HYSLogger

protocol NotificationProvider {
    var notificationService: NotificationInteractor { get }
}

struct NotificationService: NotificationInteractor {
    init() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success == false || error != nil {
                    Logger.debug(">>Notification was not setup correctly)")
                }
        }
    }
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Go back to the Procrastinee"
        content.subtitle = "Task is not completed"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "bamboo.mp3"))
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
