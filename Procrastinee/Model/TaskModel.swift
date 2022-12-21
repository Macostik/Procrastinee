//
//  File.swift
//  Procrastinee
//
//  Created by Macostik on 21.12.2022.
//

import Foundation
import SwiftUI

struct Task: Hashable {
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
    let key: String
    let value: [Task]
}

let groupTask = [
    GroupTask(key: "Today",
              value: [Task(state: .completed,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .completed,
                           type: .study,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .sport,
                           fromTime: "from 10:25 AM", forTime: "for 3h 28m"),
                      Task(state: .completed,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m")]),
    GroupTask(key: "Yesterday",
              value: [Task(state: .completed,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .completed,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .study,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .completed,
                           type: .education,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .completed,
                           type: .work,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m"),
                      Task(state: .planned,
                           type: .sport,
                           fromTime: "from 10:25 AM",
                           forTime: "for 3h 28m")])
]
