//
//  ListTableViewController.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/27/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // MARK: OPTIONAL to receive the data from MODAL
    var newListName: String?
    
    @IBAction func popAddNewList(_ sender: UIBarButtonItem) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Create Task List", message: "Enter the name of the list", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if (textField!.text!) != "" {
            addNewListOfTasks(listName: (textField!.text!))
            self.tableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "Can't create a nameless list", message:
                    "", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }

        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        //addNewListOfTasks(listName: newListName!)
        //tableView.reloadData()
        

    }
    
    // MARK: - Dresses view
    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)

        //this line cleans unused rows
        tableView.tableFooterView = UIView(frame: .zero)
        //this extends the separator lines until the end of the screen (laterals)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero

        
        
        
    }
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
  //     tableView.backgroundView = UIImageView(image: UIImage(named: "Rectangle"))
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - DATASOURCE + DATATABLE

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskListCollection.listCollection.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            fatalError("Couln't not find the right type of cell")
        }
        
        // Configure the cell
        cell.listNameLabel.text = taskListCollection.listCollection[indexPath.row].listName
        cell.counterTasksLabel.text = ""
        
        let taskCounter: Int = taskListCollection.listCollection[indexPath.row].listOfTasks?.count ?? 0
        
        if taskCounter > 0 {
            for i in 0...taskCounter - 1 {
                if !((taskListCollection.listCollection[indexPath.row].listOfTasks?[i].done)!) {
                        cell.counterTasksLabel.text = (cell.counterTasksLabel.text ?? "") + " ◉"
                }
            }
        }
        //change the cell color for today tasks here.
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // EDITING (REMOVING)
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            taskListCollection.listCollection.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: PUSH. FROM: addListViewController || TasksTableViewController  STATE: New || Update)

     @IBAction func unwindToMainList(sender: UIStoryboardSegue) {

        if let sourceViewController = sender.source as? addListViewController  {
            
            addNewListOfTasks(listName: sourceViewController.listNameText.text!)
            tableView.reloadData()
            
        } else {
           guard let taskTableViewController = sender.source as? TasksTableViewController else {
                fatalError()
            }
        
            if let selectedIndexPath = tableView.indexPathForSelectedRow  {
                taskListCollection.listCollection[selectedIndexPath.row].listOfTasks = taskTableViewController.taskArray
            }
            tableView.reloadData()
        
        }
     }
    

    // Mark: -- PULL
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        

        if (segue.identifier ?? "") == "backHome" {
            
        } else {
            
        guard let selectedListCell = sender as? ListTableViewCell else {
            fatalError("Couldn't locate click on the List. Can't navigate without an index")
        }
        
        guard let taskTableController = segue.destination as? TasksTableViewController else {
            fatalError("Couldn't locate destination TaskTableController")
        }
        
        //guard let indexPath = tableView.indexPathForSelectedRow -> try this later
        
        guard let indexPath = tableView.indexPath(for: selectedListCell) else {
            fatalError("Can't locate indexPath, hence can't send down List attributes")
        }
      
        let selectedList = taskListCollection.listCollection[indexPath.row]
        
        
        taskTableController.senderTaskListName = selectedList.listName
        
            // Preparing and seding array of tasks
        taskTableController.taskArray = selectedList.listOfTasks

        }
    }
    

}
