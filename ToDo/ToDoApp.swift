//
//  ToDoApp.swift
//  ToDo
//
//  Created by jignesh solanki on 04/10/23.
//

import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
