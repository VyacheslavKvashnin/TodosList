//
//  ContentView.swift
//  TodosList
//
//  Created by Вячеслав Квашнин on 22.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State var show = ""
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.show, ascending: true)])
    
    private var tasks: FetchedResults<Task>
    var array = ["1", "2", "3", "4", "rok", "9"]
    var totalSum: String {
        let newArr1 = array.compactMap {Int($0)}
        let newArr = newArr1.reduce(0, +)
        return ("\(newArr)")
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("Введите текст", text: $show)
                }
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title ?? "Untitle")
                        Spacer()
                        Text(task.show ?? "")
                    }
                    .onTapGesture(count: 1, perform: {
                        updateTask(task)
                    })
                }.onDelete(perform: deleteTasks)
                HStack {
                    Text("В массиве \(totalSum) элемента")
                    
                    Spacer()
                }
            }
            .navigationTitle("Todo List")
            .navigationBarItems(trailing: Button("Add Task") {
                addTask()
            })
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    private func updateTask(_ task: FetchedResults<Task>.Element) {
        withAnimation {
            task.title = "Updated"
            saveContext()
        }
    }
    
    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            offsets.map {tasks[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func addTask() {
        withAnimation {
            let newTask = Task(context: viewContext)
            newTask.show = show
            newTask.title = "New Task"
            newTask.date = Date()
            saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
