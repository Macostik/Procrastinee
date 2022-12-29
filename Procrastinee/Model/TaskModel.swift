//
//  File.swift
//  Procrastinee
//
//  Created by Macostik on 21.12.2022.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct TaskOld: Hashable {
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
    let index: Int
    let key: String
    let value: [TaskOld]
}

let groupTask = [
    GroupTask(index: 0,
              key: "Today",
              value: [TaskOld(state: .completed,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .completed,
                           type: .study,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .sport,
                           fromTime: "from 10:25 AM", forTime: "for 3h 28m"),
                      TaskOld(state: .completed,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m")]),
    GroupTask(index: 1,
              key: "Yesterday",
              value: [TaskOld(state: .completed,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .completed,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .study,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .completed,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .completed,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      TaskOld(state: .planned,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m")])
]

public struct TaskF: Codable {
    @DocumentID var id: String?
    var name: String
    var type: String
    var time: Float
}

extension TaskF {
    static let empty = TaskF(id: "", name: "", type: "", time: 0)
}
