//
//  GlobalFunctions.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/28/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import Foundation

// MARK: - Generate test dummy data
var taskList: TaskList = TaskList()
var taskList2: TaskList = TaskList()
var taskListCollection: TaskListCollection = TaskListCollection()



func setupDummyLists() -> () {
    taskList.listName = "Groceries"
    taskList2.listName = "General Assembly"
    
    taskListCollection = TaskListCollection()
    taskListCollection.addArrayOfLists(ListArray: [taskList, taskList2])
    
}

func populateListOfTasks() -> () {
    
    for item in taskListCollection.listCollection {
        for i in 1...5
        {
            guard let task = Task(Name: (item.listName + String(i) + " meetings and phone calls")) else {
                fatalError("Can't create task")
            }
            task.taskDescription = "Some important description here considering the fact that"
            item.addNewTask(todoTask: task)  //listOfTasks?.append(task)
        }
    }
    
}

func addNewListOfTasks(listName: String) -> () {
    
    let newTaskList = TaskList()
    newTaskList.listName = listName
    taskListCollection.listCollection.append(newTaskList)
}

func filterTodayTasks()-> [Task]? {
   // let calendar: NSCalendar
    var todayTasks: [Task] = []
    for list in taskListCollection.listCollection {
        if let taskArray = list.listOfTasks { // if list has tasks.
            for task in taskArray {
                if task.taskExpiresAt != nil { // if task has expDates
                    if NSCalendar.current.isDateInToday(task.taskExpiresAt!){
                         todayTasks.append(task)
                    }
                }
            }
        }
    }
    return todayTasks
}

func formatDateToDisplay(currentDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("MMMd")
    return dateFormatter.string(from: currentDate)
}

func dateTimeNow() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("MMMd")
    let result = dateFormatter.string(from: date)
    return result
}
