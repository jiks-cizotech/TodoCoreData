//
//  TaskViewModelFactory.swift
//  ToDo
//
//  Created by jignesh solanki on 06/10/23.
//

import Foundation

final class TaskViewModelFactory{
    static func createTaskViewModel() -> TaskViewModel{
        return TaskViewModel(taskRepository: TaskRepositoryImplementation())
    }
}
