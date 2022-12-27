//
//  NotificationViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 27.12.2022.
//

import Foundation
import UserNotificationsUI

class NotificationViewModel: ObservableObject {
    init() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success == false || error != nil {
                    print(">>Notification was not setup correctly)")
                }
        }
    }
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Go back to the Procrastinee"
        content.subtitle = "Task is not completed"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
