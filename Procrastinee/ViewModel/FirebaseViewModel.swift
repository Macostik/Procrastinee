//
//  FirebaseViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 27.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseViewModel: ObservableObject {
    @Published var user: User = .empty
    @Published var task: [TaskF] = []
    private var database = Firestore.firestore()
    private func fetchUsers(documentID: String) {
        let docRef = database.collection("users").document(documentID)
        docRef.getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            print(">> \(user)")
        }
    }
    private func fetchTask(documentID: String) {
        let docRef = database.collection("tasks").document(documentID)
        docRef.getDocument { snapshot, _ in
            guard let task = try? snapshot?.data(as: TaskF.self) else { return }
            print(">> \(task)")
        }
    }
    func addUser() {
        var ref: DocumentReference?
        ref = database.collection("User").addDocument(data: [
            "name": "Ada",
            "totalTime": 5
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    @MainActor
    private func fetchBookAsync(documentId: String) async {
      let docRef = database.collection("users").document(documentId)
      do {
        self.user = try await docRef.getDocument(as: User.self)
      } catch {
          print("Error getting document: \(error.localizedDescription)")
      }
    }
}
