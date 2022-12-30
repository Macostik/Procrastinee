//
//  File.swift
//  Procrastinee
//
//  Created by Macostik on 21.12.2022.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct LocalTask: Hashable {
    let id = UUID()
    let state: TaskState
    let type: TaskType
    let fromTime: String
    let forTime: String
    var taskImage: some View {
        switch type {
        case .work: return Image.workTaskIcon
        case .study: return Image.studyTaskIcon
        case .sport: return Image.sportTaskIcon
        case .education: return Image.educationTaskIcon
        }
    }
}
struct GroupTask: Hashable {
    var index: Int
    var key: String
    var value: [LocalTask]
}

var groupTask = [
    GroupTask(index: 0,
              key: "Today",
              value: [])
]

public struct RemoteTask: Codable {
    @DocumentID var id: String?
    var name: String
    var type: String
    var time: Float
}

extension RemoteTask {
    static let empty = RemoteTask(id: "", name: "", type: "", time: 0)
}
