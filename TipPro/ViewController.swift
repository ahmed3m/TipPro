//
//  ViewController.swift
//  TipPro
//
//  Created by Ahmed Abdelrahman on 6/22/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//
//  This class allows us to control our view.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Connecting the text fields with the code
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var tipAmountField: UITextField!
    @IBOutlet weak var totalAmountField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmountField.delegate = self // means that the View Controller is the delegate to this field. It can have control and functionality over it
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Connecting the calculate button to the code
    @IBAction func calculateTip(sender: AnyObject) {
        
        // checks if the input is a number. If not, it clears the fields
        guard let billAmount = Double(billAmountField.text!) else {
            //show error
            billAmountField.text = ""
            tipAmountField.text = ""
            totalAmountField.text = ""
            return
        }
        
        var tipPercentage = 0.0 // holds the percentage
        switch tipSelector.selectedSegmentIndex {  // checking which segment was selected
        case 0:
            tipPercentage = 0.15
        case 1:
            tipPercentage = 0.18
        case 2:
            tipPercentage = 0.20
        default:
            break
        }
        
        // calculating the tip amount and the total amount
        let roundedBillAmount = round(100*billAmount)/100
        let tipAmount = roundedBillAmount * tipPercentage
        let roundedTipAmount = round(100*tipAmount)/100
        let totalAmount = roundedBillAmount + roundedTipAmount
        
        // checking if the bill amount field is being edited. If it is, then don't round to two decimal places
        if (!billAmountField.editing) {
            billAmountField.text = String(format: "%.2f", roundedBillAmount)
        }
        
        // setting the text in the textFields to the amounts calculated
        tipAmountField.text = String(format: "%.2f", roundedTipAmount)
        totalAmountField.text = String(format: "%.2f", totalAmount)
    }
    
    // Used to make the status bar prettier
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

