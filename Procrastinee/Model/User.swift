//
//  User.swift
//  Procrastinee
//
//  Created by Macostik on 27.12.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

public struct User: Codable {
    @DocumentID var id: String?
    var name: String
    var country: String
    var totalTime: String
    var tasks: [String]?
}

extension User {
    static let empty = User(id: nil,
                            name: "",
                            country: "",
                            totalTime: "")
}
