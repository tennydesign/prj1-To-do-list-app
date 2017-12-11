//
//  AddTaskViewController.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/27/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit


class AddTaskViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var taskNameTxtField: UITextField!
    
    @IBOutlet weak var switchOnCalendar: UISwitch!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    var task: Task?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var taskDescriptionTxtField: UITextView!

    
    @IBAction func toggleCalendar(_ sender: UISwitch) {
        if sender.isOn {
            datePicker.isEnabled = true
        } else {
            datePicker.isEnabled = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameTxtField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        // fixes bug on datepicker... 
        datePicker.setValue(UIColor.yellow, forKeyPath: "textColor")
        datePicker.datePickerMode = .date

        
        // initialize task coming from the segue
        if let task = task  {
            //navigationItem.title = task.taskName
            taskNameTxtField.text = task.taskName
            taskDescriptionTxtField.text = task.taskDescription

            if let dateExist = task.taskExpiresAt {
                datePicker.isEnabled = true
                switchOnCalendar.isOn = true
                datePicker.date = dateExist
            } else {
                datePicker.isEnabled = false
            }
            
            //datePicker.date = task.taskExpiresAt ?? datePicker.date // if no date, initializes the picker with the default starting date
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TXTFIELD Delegates:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
        addBtn.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if taskNameTxtField.text == "" {
            saveButton.isEnabled = false
        } else {
            navigationItem.title = taskNameTxtField.text
            saveButton.isEnabled = true
            addBtn.isEnabled = true
        }
    }
    
    // MARK: Gestures
    @IBAction func userTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    // MARK: Other Actions
    @IBAction func hitCancel(_ sender: UIBarButtonItem) {
        
        let isAddingNewTask = presentingViewController is UINavigationController
        
        // this is the ideal response for the modal popup, won't work with the  show details segue
        if isAddingNewTask {
            dismiss(animated: true, completion: nil)
        } else {// this one will
            
            //this is calling back the previous controller
            guard let assignedNavController = navigationController else {
                fatalError("This view is not wired to a navigation controller")
            }
            assignedNavController.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let taskName = taskNameTxtField.text ?? ""
        
        task = Task(Name: taskName)
        if datePicker.isEnabled {
            task?.taskExpiresAt = datePicker.date
        }
        task?.taskDescription = taskDescriptionTxtField.text
        
    }
    
    
}

// MARK: Extension
// This extension adds a "tap elsewhere hide the keyboard" action.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

