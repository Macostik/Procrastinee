//
//  FirebaseProvider.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation
import Combine
import HYSLogger
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

private var listeners: [AnyHashable: Listener] = [:]
private struct Listener {
    let document: CollectionReference
    let listener: ListenerRegistration
    let subject: PassthroughSubject<[QueryDocumentSnapshot], Never>
}

struct FirestoreSubscription {
    static func subscribe(id: AnyHashable, docPath: String) -> AnyPublisher<[QueryDocumentSnapshot], Never> {
        let subject = PassthroughSubject<[QueryDocumentSnapshot], Never>()
        let docRef = Firestore.firestore().collection(docPath)
        let listener = docRef.addSnapshotListener { snapshot, _ in
            if let snapshot = snapshot {
                subject.send(snapshot.documents)
            }
        }
        listeners[id] = Listener(document: docRef, listener: listener, subject: subject)
        return subject.eraseToAnyPublisher()
    }
    static func cancel(id: AnyHashable) {
        listeners[id]?.listener.remove()
        listeners[id]?.subject.send(completion: .finished)
        listeners[id] = nil
    }
}

struct FirestoreDecoder {
    static func decode<T>(_ type: T.Type) -> (QueryDocumentSnapshot) -> T? where T: Decodable {
        { snapshot in
            try? snapshot.data(as: type.self)
        }
    }
    static func decode<T>(_ type: T.Type) -> ([QueryDocumentSnapshot]) -> [T]? where T: Decodable {
        { snapshot in
            try? snapshot.compactMap({ try $0.data(as: type.self) })
        }
    }
}

protocol FirebaseProvider {
    var firebaseService: FirebaseInteractor { get }
}

class FirebaseService: FirebaseInteractor {
    var currentUser = CurrentValueSubject<User, Error>(.empty)
    var users = CurrentValueSubject<[User], Error>([])
    var tasks = CurrentValueSubject<[TaskItem], Error>([])
    struct SubscriptionID: Hashable {}
    private var dataBase = Firestore.firestore()
    private var cancellable: Set<AnyCancellable> = []
    init() {
        addListener()
    }
    private func addListener() {
        FirestoreSubscription.subscribe(id: SubscriptionID(), docPath: "User")
            .compactMap(FirestoreDecoder.decode(User.self))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] users in
                Logger.info("List of users: \(users)")
                self?.users.value = users
                self?.getCurrentUser()
                self?.fetchAllTasks()
            })
            .store(in: &cancellable)
    }
    private func getCurrentUser() {
        users
            .compactMap({ $0.filter({ $0.name == UserDefaults.standard
                .string(forKey: Constants.userNickname) }).first })
            .sink { _ in
            } receiveValue: { [weak self] user in
                Logger.info("Current user: \(user)")
                self?.currentUser.value = user
            }
            .store(in: &cancellable)
    }
    private func fetchAllTasks() {
        currentUser
            .sink { _ in
            } receiveValue: { user in
                guard let tasks = user.tasks else { return }
                var tasksList: [TaskItem] = []
                for task in tasks where task.isEmpty == false {
                    guard let remoteTask = try? JSONDecoder()
                        .decode(TaskItem.self,
                                from: task.data(using: .utf8)!)
                    else { return }
                    tasksList.append(remoteTask)
                }
                self.tasks.value = tasksList
            }
            .store(in: &cancellable)
    }
    func addUser(name: String, country: String) {
        var ref: DocumentReference?
        ref = dataBase.collection("User").addDocument(data: [
            "name": name,
            "country": country,
            "todayFocused": 0,
            "dailyAverage": 0,
            "totalWeekly": 0,
            "tasks": [""]
        ]) { err in
            if let err = err {
                Logger.error("Error adding document: \(err)")
            } else {
                Logger.debug("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    func addTask(task: TaskItem) {
        DispatchQueue.global(qos: .background).async {
            if let encodedTask = try? JSONEncoder().encode(task) {
                if let jsonTask = String(data: encodedTask, encoding: .utf8) {
                    let ref = self.dataBase.collection("User")
                        .document(self.currentUser.value.id ?? "")
                    ref.updateData([
                        "tasks": FieldValue.arrayUnion([jsonTask])
                    ])
                }
            }
        }
    }
    func updateTrackUserTimes(todayTotalTime: Int,
                              dailyAverage: Int,
                              totalWeekly: Int) {
        DispatchQueue.global(qos: .background).async {
            self.dataBase.collection("User").document(self.currentUser.value.id ?? "")
                .getDocument(completion: { snapshot, _ in
                    snapshot?.reference.updateData([
                        "todayFocused": todayTotalTime,
                        "dailyAverage": dailyAverage,
                        "totalWeekly": totalWeekly
                    ])
                    Logger.debug("Update tracker user times")
                })
        }
    }
    func updateFinishedTask(with name: String) {
        DispatchQueue.global(qos: .background).async {
            let ref = self.dataBase.collection("User")
                .document(self.currentUser.value.id ?? "")
                .collection("tasks")
            print(">> \(ref)")
        }
    }
}
