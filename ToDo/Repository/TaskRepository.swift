//
//  TaskRepository.swift
//  ToDo
//
//  Created by jignesh solanki on 06/10/23.
//

import Foundation
import CoreData.NSManagedObjectContext

protocol TaskRepository{
    func get(isCompleted : Bool) -> [Task]
    func update(task : Task) -> Bool
    func add(task: Task) -> Bool
    func delete(task: Task) -> Bool
}

final class TaskRepositoryImplementation : TaskRepository{
    
    private let manageObjectContext : NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func get(isCompleted: Bool) -> [Task] {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
        do{
            let result = try manageObjectContext.fetch(fetchRequest)
            if(!result.isEmpty){
                return result.map({Task(id: $0.id! , name: $0.name ?? "", description: $0.taskDescription ?? "", isCompleted: $0.isCompleted, finishDateTime: $0.finishDate ?? Date())})
            }
        }
        catch{
            print("error  to get = \(error.localizedDescription)")
        }
        return []
    }
    
    func update(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do{
            if let existingTask = try manageObjectContext.fetch(fetchRequest).first{
                existingTask.name = task.name
                existingTask.taskDescription = task.description
                existingTask.finishDate = task.finishDateTime
                existingTask.isCompleted = task.isCompleted
                
                try manageObjectContext.save()
                return true
            }
            else
            {
                print("No task found with id = \(task.id)")
                return false
            }
        }
        catch{
            print("error = \(error.localizedDescription)")
        }
        return false
    }
    
    func add(task: Task) -> Bool {
        let taskEntity = TaskEntity(context: manageObjectContext)
        taskEntity.id = UUID()
        taskEntity.finishDate = task.finishDateTime
        taskEntity.isCompleted = false
        taskEntity.taskDescription = task.description
        taskEntity.name = task.name
        do{
            try manageObjectContext.save()
            return true
        }
        catch{
            print("error on add = \(error.localizedDescription)")
        }
        return false
    }
    
    func delete(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do{
            if let existingTask = try manageObjectContext.fetch(fetchRequest).first{
              
                
                manageObjectContext.delete(existingTask)
                try manageObjectContext.save()
                return true
            }
            else
            {
                print("delete No task found with id = \(task.id)")
                return false
            }
        }
        catch{
            print("error on delete= \(error.localizedDescription)")
        }
        return false
    }
    
    
}
