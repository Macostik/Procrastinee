//
//  FacebookInteractor.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation
import Combine

protocol FirebaseInteractor {
    var currentUser: User { get }
    var users: [User] { get }
    var tasks: CurrentValueSubject<[RemoteTask], Error> { get }
    func addUser(name: String, country: String, totalTime: String)
    func addTask(task: RemoteTask)
}
