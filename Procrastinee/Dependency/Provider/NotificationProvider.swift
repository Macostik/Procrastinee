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
    func requestNotificationPermission(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success == false || error != nil {
                    Logger.debug("Notifications were not setup correctly")
                } else {
                    Logger.debug("Notifications were setup correctly")
                }
                completion()
        }
    }
    func sendAlertNotification(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Go back to the Procrastinee"
        content.subtitle = "The task is not completed"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "bamboo.mp3"))
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval,
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
        let scheduleTime = task.fromTime.components(separatedBy: " ")
        let timeComponent = scheduleTime.first?.components(separatedBy: ":")
        var hour = Int(timeComponent?.first ?? "") ?? 0
        let amPm = scheduleTime.last ?? ""
        hour = amPm == "AM" ? hour : hour + 12
        let minute = Int(timeComponent?.last ?? "") ?? 0
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
