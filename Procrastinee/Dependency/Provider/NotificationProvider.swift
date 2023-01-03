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
                    Logger.debug("Notifications were not setup correctly")
                } else {
                    Logger.debug("Notifications were setup correctly")
                }
        }
    }
    func sendAlertNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Go back to the Procrastinee"
        content.subtitle = "The task is not completed"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "bamboo.mp3"))
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    func scheduleNotification(with task: TaskItem) {
        let content = UNMutableNotificationContent()
        content.title = "\(task.name)"
        content.subtitle = "Task has to be started. Return to application please"
        var dateComponents = DateComponents()
        let removePeriod = task.fromTime
            .components(separatedBy: " ")
        let timeComponent = removePeriod.first?
            .components(separatedBy: ":")
        dateComponents.hour = Int(timeComponent?.first ?? "")
        dateComponents.minute = Int(timeComponent?.last ?? "")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
