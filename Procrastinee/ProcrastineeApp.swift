//
//  ProcrastineeApp.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

@main
struct ProcrastineeApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
