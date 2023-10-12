//
//  TaskDetailsView.swift
//  ToDo
//
//  Created by jignesh solanki on 05/10/23.
//

import SwiftUI

struct TaskDetailsView: View {
    @ObservedObject var taskViewModel : TaskViewModel
    @Binding var Selectedtask : Task
    @Binding var showTaskDetailsView : Bool
    @Binding var refreshTaskList : Bool
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                
                Section(header: Text("Task Detail")){
                    TextField("Task name" , text:$Selectedtask.name)
                    TextEditor(text: $Selectedtask.description)
                    Toggle("Mark Complete", isOn: $Selectedtask.isCompleted)
                }
                
                Section(header: Text("Task date/Time"))
                {
                    //DatePicker("Task Date" , selection: $Selectedtask.finishDateTime)
                    DatePicker("Task Date" , selection: $Selectedtask.finishDateTime , in: Date()...Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
                }
                
                Section{
                    Button{
                        print("Delete Task Tap")
                        showDeleteAlert.toggle()

                    } label: {
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment : .center)
                            
                    }.alert("Delete Task?", isPresented: $showDeleteAlert){
                        Button{
                            showTaskDetailsView.toggle()
                        } label: {
                            Text("No")
                        }
                        
                        Button(role: .destructive){
                            if(taskViewModel.deleteTask(task: Selectedtask))
                             {
                                showTaskDetailsView.toggle()
                                refreshTaskList.toggle()
                            }
                        } label: {
                            Text("Yes")
                        }
                        
                    }
                }
                
            }.navigationTitle("Task Detail")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button{
                            print("Cancle Button Tap")
                            showTaskDetailsView.toggle()
                        } label: {
                            Text("Cancle")
                        }
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            print("Update Button Tap")
                            if(taskViewModel.updateTask(task: Selectedtask))
                            {
                                showTaskDetailsView.toggle()
                                refreshTaskList.toggle()
                            }
                        }label: {
                            Text("Update")
                        } .disabled(Selectedtask.name.isEmpty)
                    }
                }
        }
    }
}

#Preview {
    TaskDetailsView(taskViewModel: TaskViewModelFactory.createTaskViewModel(), Selectedtask: .constant(Task.createEmptyTasks()), showTaskDetailsView: .constant(false), refreshTaskList: .constant(false))
}
