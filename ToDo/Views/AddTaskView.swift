//
//  AddTaskView.swift
//  ToDo
//
//  Created by jignesh solanki on 05/10/23.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var taskViewModel : TaskViewModel
    @State private var taskToAdd : Task = Task.createEmptyTasks()//Task(id: 0, name: "", description: "", isCompleted: false, finishDateTime: Date())
    @Binding var showAddTaskView : Bool
    @Binding var refreshTaskList : Bool
    @State var showDirtyAlert : Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                
                Section(header: Text("Task Details")){
                    TextField("Task name" , text: $taskToAdd.name)
                    TextEditor(text: $taskToAdd.description)
                }
                
                Section(header: Text("Task date/Time"))
                {
                   // DatePicker("Task Date" , selection: $taskToAdd.finishDateTime , in: ...Date())
                    DatePicker("Task Date" , selection: $taskToAdd.finishDateTime , in: Date()...Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
                }
            }.navigationTitle("Add Task")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button{
                            print("Cancle Button Tap")
                            if(!taskToAdd.name.isEmpty)
                            {
                                //Show Alert Validation
                                showDirtyAlert.toggle()
                            }
                            else
                            {
                                showAddTaskView.toggle()
                            }
                        } label: {
                            Text("Cancle")
                        }.alert("Save Task" , isPresented:  $showDirtyAlert){
                            
                            Button{
                                showAddTaskView.toggle()
                            } label: {
                                Text("Cancle")
                            }
                            
                            Button{
//                                if(taskViewModel.addTask(task: taskToAdd))
//                                {
//                                    showAddTaskView.toggle()
//                                    refreshTaskList.toggle()
//                                }
                                addtask()
                            } label: {
                                Text("Save")
                            }
                        } message: {
                            Text("Would you like to save the task?")
                        }
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            print("Add Button Tap")
                            addtask()
                        }label: {
                            Text("Add")
                        }.disabled(taskToAdd.name.isEmpty)
                    }
                }
        }
    }
    private func addtask()
    {
        if(taskViewModel.addTask(task: taskToAdd))
        {
            showAddTaskView.toggle()
            refreshTaskList.toggle()
        }
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModelFactory.createTaskViewModel(), showAddTaskView: .constant(false), refreshTaskList: .constant(false))
}
