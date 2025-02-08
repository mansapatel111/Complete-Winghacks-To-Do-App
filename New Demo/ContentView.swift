//
//  ContentView.swift
//  Newest Demo
//
//  Created by Mansa Patel on 2/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    var body: some View {
        if isActive{
            MainView()
        } else {
            VStack{
                Text("Hello Hackers, Welcome Back!!!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.pink)
                Button(action: {isActive = true}) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundStyle(Color.pink)
                        .frame(width: 70.0, height: 70.0)
                  
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pink.opacity(0.3))
        }
        
    }
}

struct MainView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    
    var body: some View {
    
        VStack {
            Text("🌸 My To Do List: 🌸")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding()
            HStack{
                TextField("Add a new task ...", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(25)
                Button(action: {if !newTaskTitle.isEmpty{
                    viewModel.addTask(title: newTaskTitle)
                    newTaskTitle = ""}})
                {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.pink)
                        .frame(width: 40.0, height: 40.0)
                    
                }
            }
            List {
                ForEach(viewModel.tasks) {task in
                    HStack{
                        Image(systemName: task.isCompleted ? "heart.fill" : "heart")
                            .foregroundColor(task.isCompleted ? .red : .gray)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.toggleCompletion(for: task)
                                }
                            }
                        
                        
                        Text(task.title)
                            .strikethrough(task.isCompleted, color: .pink)
                            .foregroundColor(task.isCompleted ? .gray : .black)
                        
                        Spacer()
                        
                        Image(systemName: task.isCompleted ? "xmark.bin" : "xmark.bin.fill")
                            .foregroundColor(task.isCompleted ? .red : .gray)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.toggleDeletion(for: task)
                                }
                                
                            }
                    }
                    
                }
                
            }
            
        }
   
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.pink.opacity(0.3))

    }
}

#Preview {
    ContentView()
}
