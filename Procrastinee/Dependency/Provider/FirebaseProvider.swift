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
    @Published var currentUser: User = .empty
    @Published var users: [User] = []
    struct SubscriptionID: Hashable {}
    private var dataBase = Firestore.firestore()
    private var cancellable: Set<AnyCancellable> = []
    init() {
        addListener()
        getCurrentUser()
    }
    private func addListener() {
        FirestoreSubscription.subscribe(id: SubscriptionID(), docPath: "User")
            .compactMap(FirestoreDecoder.decode(User.self))
            .receive(on: DispatchQueue.main)
            .print("List of users")
            .assign(to: \.users, on: self)
            .store(in: &cancellable)
    }
    private func getCurrentUser() {
        $users
            .compactMap({ $0.filter({ $0.name == UserDefaults.standard
                .string(forKey: Constants.userNickname) }).first })
            .print("Current user")
            .assign(to: \.currentUser, on: self)
            .store(in: &cancellable)
    }
    func addUser(name: String, country: String, totalTime: String) {
        var ref: DocumentReference?
        ref = dataBase.collection("User").addDocument(data: [
            "name": name,
            "country": country,
            "totalTime": totalTime,
            "tasks": [""]
        ]) { err in
            if let err = err {
                Logger.error("Error adding document: \(err)")
            } else {
                Logger.debug("Document added with ID: \(ref!.documentID)")
                self.getCurrentUser()
            }
        }
    }
    func addTask(task: RemoteTask) {
        if let encodedTask = try? JSONEncoder().encode(task) {
            if let jsonTask = String(data: encodedTask, encoding: .utf8) {
                let ref = dataBase.collection("User").document(currentUser.id!)
                ref.updateData([
                    "tasks": FieldValue.arrayUnion([jsonTask])
                ])
            }
        }
    }
}
