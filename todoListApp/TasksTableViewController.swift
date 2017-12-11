//
//  TasksTableViewController.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/27/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    
    //MARK: -- Initializing variables.
    var taskListCollection = TaskListCollection()
    var senderTaskListName: String?
    var taskArray: [Task]?
    var viewloadFlagShot: Bool = true
    
    
    //MARK: -- View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this creates a full backgrounc for the table
        //tableView.backgroundView = UIImageView(image: UIImage(named: "Rectangle"))
        viewloadFlagShot = true // first time the view loads (to separate from when the tableView reloads.
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        //this line cleans unused rows
        //this extends the separator lines until the end of the screen (laterals)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - DATASOURCE + DATATABLE
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let counter = taskArray?.count ?? 0
        return counter
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            fatalError("couldn't find the cell type TaskTableViewCell")
        }
        
        // Configure the cell...
        
        
        cell.taskNameLabel.text = taskArray?[indexPath.row].taskName
        
        let description: String = taskArray?[indexPath.row].taskDescription ?? ""
        
        cell.taskDescription.text = description
    

        if let expireDate = taskArray?[indexPath.row].taskExpiresAt {
            cell.dateExpiresLabel.text = formatDateToDisplay(currentDate: expireDate)
        } else {
            cell.dateExpiresLabel.text = ""
        }
        
        //let expireDate = taskArray?[indexPath.row].taskExpiresAt
        /*
        if expireDate != nil {
            cell.dateExpiresLabel.text = formatDateToDisplay(currentDate: expireDate!)
        } else {
            cell.dateExpiresLabel.text = ""
        }
        */
        
        if (taskArray?[indexPath.row].done)! {
            cell.labelDone.text = "✓"
        }
        
        viewloadFlagShot = false // indicates that for now on the table will reload not the entire view (until a segue takes place)
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // EDITING (REMOVING)
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //      taskArray?.remove(at: indexPath.row)
            //      tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell
        let action1 = UITableViewRowAction(style: .default, title: "Done", handler: {
            (action, indexPath) in
            
            
             
            if !(self.viewloadFlagShot) {
                if cell?.labelDone.text == "✓" {
                    cell?.labelDone.text = ""
                    self.taskArray?[indexPath.row].done = false
                } else {
                    cell?.labelDone.text = "✓"
                    self.taskArray?[indexPath.row].done = true
                }
            }
            tableView.reloadData()
            
        })
        action1.backgroundColor = UIColor(red: 70.0/255, green: 190.0/255, blue: 188.0/255, alpha: 1.0)
        let action2 = UITableViewRowAction(style: .default, title: "Delete", handler: {
            (action, indexPath) in
            
            self.taskArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        return [action1, action2]
        
    }
    
    //Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    
    // MARK: PUSH. FROM: AddTaskViewController STATE: update || new)
    @IBAction func unwindToTasks(sender: UIStoryboardSegue) {
        
        guard let fromModalViewControl = sender.source as? AddTaskViewController else {
            fatalError(" Not coming from addTask window" )
        }
        
        guard let newTask = fromModalViewControl.task else {
            fatalError(" Coundn't find the task created")
        }
        
        // This returns true if a row was selected (AKA - UPDATE)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            // this is updating the row.
            taskArray?[selectedIndexPath.row] = fromModalViewControl.task!
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else { // AKA - New item
            
            // this is creating a new item and updating the tableView.
            let newIndexPath = IndexPath(row: (taskArray?.count)!, section: 0)
            //taskList.addNewTask(todoTask: newTask)
            taskArray?.append(newTask)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
    
    // MARK: -- PULL TO: AddTaskViewController STATE: Update
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let segueId = segue.identifier ?? ""
        if (segueId == "editTask") {
            guard let taskDetailsView = segue.destination as? AddTaskViewController else {fatalError()}
            
            guard let selectedTaskCell = sender as? TaskTableViewCell else {fatalError()}
            
            guard let IndexPath = tableView.indexPath(for: selectedTaskCell) else {fatalError()}
            
            
            //let selectedTask = taskList.listOfTasks![IndexPath.row]
            let selectedTask = taskArray?[IndexPath.row]
            
            taskDetailsView.task = selectedTask
        }
    }
    
    
    
}
