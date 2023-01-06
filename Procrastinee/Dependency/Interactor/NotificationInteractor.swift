//
//  NotificationInteractor.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation

protocol NotificationInteractor {
    func sendAlertNotification(with interval: TimeInterval)
    func scheduleNotification(with task: TaskItem)
}
