//
//  FacebookInteractor.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation
import Combine

protocol FirebaseInteractor {
    var currentUser: CurrentValueSubject<User, Error> { get }
    var users: CurrentValueSubject<[User], Error> { get }
    var tasks: CurrentValueSubject<[RemoteTask], Error> { get }
    func addUser(name: String, country: String, totalTime: String)
    func addTask(task: RemoteTask)
}
