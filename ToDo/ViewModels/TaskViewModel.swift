//
//  TaskViewModel.swift
//  ToDo
//
//  Created by jignesh solanki on 04/10/23.
//

import Foundation

final class TaskViewModel : ObservableObject{
    
    
    
    private let taskRepository : TaskRepository
    @Published var tasks : [Task] = []
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
//    private var tempTask = Task.createEmptyTasks()
    
    func getTasks(isCompleted : Bool)
    {
        self.tasks = taskRepository.get(isCompleted: !isCompleted)
    }
    
    func addTask(task : Task) -> Bool{
        
        return taskRepository.add(task: task)
    }
    
    func updateTask(task : Task) -> Bool{
      
        return taskRepository.update(task: task)
    }
    
    func deleteTask(task : Task) -> Bool{
        
        return taskRepository.delete(task: task)
    }
}
