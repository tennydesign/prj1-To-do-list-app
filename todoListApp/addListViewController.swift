//
//  addListViewController.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/28/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit


class addListViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var listNameText: UITextField!
    @IBOutlet weak var addListButton: UIBarButtonItem!
   
    
    
    //var newTaskList: TaskList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listNameText.delegate = self
        self.hideKeyboardWhenTappedAround()
   


        // Do any additional setup after loading the view.
    }
    
    // MARK: Gestures
    @IBAction func userTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    // MARK: TextInput delegates:
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addListButton.isEnabled = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
 
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = listNameText.text
        addListButton.isEnabled = true
        
    }
    
  
    @IBAction func hitCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
