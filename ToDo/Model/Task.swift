//
//  Task.swift
//  ToDo
//
//  Created by jignesh solanki on 04/10/23.
//

import Foundation
struct Task {
    let id: UUID
    var name: String
    var description: String
    var isCompleted: Bool
    var finishDateTime: Date
    
    static func createEmptyTasks() -> Task {
        return Task (id: UUID(), name: "", description: "", isCompleted: false, finishDateTime: Date())
    }
}
