//
//  IntroViewController.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/28/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var ordinalDescription: UILabel!
    @IBOutlet weak var Month: UILabel!
    @IBOutlet weak var DayNum: UILabel!
    @IBOutlet weak var Day: UILabel!
    @IBOutlet weak var welcome_msg: UILabel!
    @IBOutlet weak var introTableVIew: UITableView!
    var activeTasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.introTableVIew.dataSource = self
        
        //tasks = filterTodayTasks() ?? []
        activeTasks = (filterTodayTasks() ?? []).filter({ $0.done == false})
        welcome_msg.text = "You have " + String(activeTasks.count) + " tasks due today:" //-- trying.
        introTableVIew.separatorColor = UIColor.clear
        
        self.introTableVIew.backgroundView?.backgroundColor = UIColor.clear
        
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
        Day.text = dateFormatter.string(from: date as Date)//"Sunday"
        dateFormatter.dateFormat  = "MMMM"
        Month.text = dateFormatter.string(from: date as Date)
        dateFormatter.dateFormat  = "dd"
        DayNum.text = dateFormatter.string(from: date as Date)

        if let weekday = DayNum.text {
            switch (weekday) {
            case "01":
                    ordinalDescription.text = "st"
            case "02":
                    ordinalDescription.text = "nd"
            case "03":
                    ordinalDescription.text = "rd"
            default:
                    ordinalDescription.text = "th"
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        introTableVIew.tableFooterView = UIView(frame: .zero)
        activeTasks = (filterTodayTasks() ?? []).filter({ $0.done == false})
        welcome_msg.text = "You have " + String(activeTasks.count) + " tasks due today:" //-- trying.
        introTableVIew.reloadData()
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // MARK: TableView config
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIntroTableVIew", for: indexPath) as? IntroTableViewCell else {
            fatalError("Couln't not find the right type of cell")
        }
        cell.backgroundColor = .clear
        
        cell.txtLabelShow.text = activeTasks[indexPath.row].taskName
        cell.txtDetailsTask.text = activeTasks[indexPath.row].taskDescription
        
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
