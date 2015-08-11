//
//  ViewController.swift
//  CheckBox
//
//  Created by 周泽勇 on 15/8/10.
//  Copyright (c) 2015年 周泽勇. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var checkbox: UICheckbox!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func onColorChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            checkbox.checkboxColor = UIColor.blackColor()
        }else if sender.selectedSegmentIndex == 1 {
            checkbox.checkboxColor = UIColor.blueColor()
        }else if sender.selectedSegmentIndex == 2 {
            checkbox.checkboxColor = UIColor.redColor()
        }
    }
    
    @IBAction func onStateChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            checkbox.enabled = true
        }else if sender.selectedSegmentIndex == 1 {
            checkbox.enabled = false
        }
    }
    
    @IBAction func textChanged(sender: UITextField) {
        checkbox.text = sender.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.checkbox.addTarget(self, action: "checkboxDidChange:", forControlEvents: UIControlEvents.ValueChanged)
        checkbox.textLabel.text = "Demo Text"
        checkbox.checkboxAlignment = UICheckboxAlignment.Right
    }
    
    func checkboxDidChange(checkbox:UICheckbox) {
        if checkbox.checked {
            label.text = "Checked"
        }else {
            label.text = "Not checked"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

