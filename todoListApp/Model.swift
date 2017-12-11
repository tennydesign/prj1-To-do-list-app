//
//  Model.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/27/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import Foundation

class Task{
    
    var taskName: String
    var taskDescription: String?
    var taskExpiresAt: Date?
    var done: Bool = false
    
    init?(Name: String) {
        guard !Name.isEmpty else{
            return nil
        }
        taskName = Name
        
    }
    
    func isDueToday(DateAsString: String) -> Bool {
        var stringDate = "Oct 27"
        return true
    }
    
}

class TaskList {
    
    var listName: String = ""
    var listOfTasks: [Task]? = []
    
    func addNewTask (TaskName: String) -> () {
        
        guard let newTask = Task(Name: TaskName) else {
            fatalError()
        }
        listOfTasks?.append(newTask)
        
    }
    
    func addNewTask (todoTask: Task) -> () {
        
        listOfTasks?.append(todoTask)
        
    }
    
    func removeTask (TaskName: String) -> Bool {
        
        if !(listOfTasks?.contains{$0.taskName == TaskName})! {
            return false
        }
        listOfTasks = listOfTasks?.filter{$0.taskName == TaskName}
        return true
    }
}

class TaskListCollection {
    
  var listCollection: [TaskList] = []
    
//    init () {
//        taskListCollection = TaskListCollection()
//    }
//
//    func addNewListOfTasks (listname: String) -> () {
//        let tasklist = TaskList()
//        tasklist.listName = listname
//        listCollection.append(tasklist)
//    }
//
    func addArrayOfLists(ListArray: [TaskList]) ->() {
        listCollection.append(contentsOf: ListArray)
    }
    
}



