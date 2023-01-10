//
//  File.swift
//  Procrastinee
//
//  Created by Macostik on 21.12.2022.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct TaskItem: Hashable, Codable {
    var id = UUID().uuidString
    var state: String
    let type: String
    let name: String
    let fromTime: String
    var forTime: String
    var timestamp = Date().timeIntervalSince1970
}
extension TaskItem {
    var taskType: TaskType {
        TaskType(rawValue: type) ?? .sport
    }
    var taskImage: some View {
        switch taskType {
        case .work: return Image.workTaskIcon
        case .study: return Image.studyTaskIcon
        case .sport: return Image.sportTaskIcon
        case .education: return Image.educationTaskIcon
        }
    }
    var convertFromTimeToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.date(from: fromTime) ?? Date()
    }
    static let empty = TaskItem(state: "",
                                type: "",
                                name: "",
                                fromTime: "",
                                forTime: "")
}
struct GroupTask: Hashable {
    var index: Int
    var key: String
    var value: [TaskItem]
}
