//
//  HomeView.swift
//  ToDo
//
//  Created by jignesh solanki on 04/10/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var taskViewModel : TaskViewModel = TaskViewModelFactory.createTaskViewModel()
    @State private var pickerFilters : [String] = ["Active" , "Completed"]
    @State private var defaultPickerSelectedItem: String = "Active"
    @State private var showAddTaskView : Bool = false
    @State private var showTaskDetailView : Bool = false
    @State private var selectedTask : Task = Task.createEmptyTasks()//Task(id: 0, name: "", description: "", isCompleted: false, finishDateTime: Date())

    @State var refreshTaskList : Bool = false
    
    var body: some View {
        NavigationStack{
            
            Picker("Picker Filter " , selection: $defaultPickerSelectedItem){
                ForEach(pickerFilters , id:\.self){
                    Text($0)
                }
                
            }.pickerStyle(.segmented)
                .onChange(of: defaultPickerSelectedItem){
                    taskViewModel.getTasks(isCompleted: defaultPickerSelectedItem == "Active")
                }
            
            List(taskViewModel.tasks , id: \.id){ task in
                VStack(alignment: .leading){
                    Text(task.name).font(.title)
                    HStack(alignment: .firstTextBaseline){
                        Text(task.description)
                        Spacer()
                        Text("\(task.finishDateTime.toString())").font(.subheadline)
                    }
                }.onTapGesture {
                    selectedTask = task
                    showTaskDetailView.toggle()
                }
            }.onAppear{
                taskViewModel.getTasks(isCompleted: true)
            }.onChange(of: refreshTaskList , perform : {_ in
                taskViewModel.getTasks(isCompleted: defaultPickerSelectedItem == "Active")
            })
            .listStyle(.sidebar)
                .navigationTitle("Home")
            
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            print("add task View")
                            showAddTaskView = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }      
                    }
                }
                .sheet(isPresented: $showAddTaskView){
                    
                    AddTaskView(taskViewModel: taskViewModel, showAddTaskView: $showAddTaskView, refreshTaskList: $refreshTaskList)
                }
                .sheet(isPresented: $showTaskDetailView){
                    
                    TaskDetailsView(taskViewModel: taskViewModel , Selectedtask: $selectedTask , showTaskDetailsView: $showTaskDetailView, refreshTaskList: $refreshTaskList)
                }
        }
    }
}

#Preview {
    HomeView()
}
