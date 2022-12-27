//
//  FirebaseViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 27.12.2022.
//

import Foundation

class FirebaseViewModel: ObservableObject {
    @Published var user: User = .empty
    @Published var task: [TaskF] = []
    
    private func fetchUsers() {
        let docRef = db.collection("users").document(documentId)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                self.errorMessage = "Error getting document: \(error.localizedDescription)"
            }
            else {
                if let document = document {
                    let id = document.documentID
                    let data = document.data()
                    let name = data?["name"] as? String ?? ""
                    let totalTime = data?["totalTime"] as? Float ?? 0
                    self.user = User(name: name, totalTime: totalTime)
                }
            }
        }
    }
    
    private func fetchTask(documentId: String) {
        let docRef = db.collection("users").document(documentId)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                self.errorMessage = "Error getting document: \(error.localizedDescription)"
            }
            else {
                if let document = document {
                    let id = document.documentID
                    let data = document.data()
                    let name = data?["name"] as? String ?? ""
                    let name = data?["type"] as? String ?? ""
                    let time = data?["time"] as? Float ?? 0
                    self.task = TaskF(name: id, name: name, type: type, time: time)
                }
            }
        }
    }
    
    @MainActor
    private func fetchBookAsync(documentId: String) async {
      let docRef = db.collection("users").document(documentId)
      do {
        self.user = try await docRef.getDocument(as: User.self)
      }
      catch {
        switch error {
        case DecodingError.typeMismatch(_, let context):
          self.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
        case DecodingError.valueNotFound(_, let context):
          self.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
        case DecodingError.keyNotFound(_, let context):
          self.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
        case DecodingError.dataCorrupted(let key):
          self.errorMessage = "\(error.localizedDescription): \(key)"
        default:
          self.errorMessage = "Error decoding document: \(error.localizedDescription)"
        }
      }
    }
}
