//
//  FacebookInteractor.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation

protocol FirebaseInteractor {
    var currentUser: User { get }
    var users: [User] { get }
    func addUser(name: String, country: String, totalTime: String) 
    func addTask(task: RemoteTask)
}
