//
//  ViewController.swift
//  MMPickerViewExample
//
//  Created by Mohsin on 19/01/2016.
//  Copyright © 2016 Mohsin. All rights reserved.
//

import UIKit


enum TypeSelector{
    case SelectName
    case SelectDOB
    case SelectNumber
    case SelectTime
}



class ViewController: UIViewController, MMPickerViewDelegate {
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var btnDOB: UIButton!
    @IBOutlet weak var btnNumber: UIButton!
    @IBOutlet weak var btnTime: UIButton!

    var selectedType = TypeSelector.SelectName
    
    let names = ["Claude Gambrel",
    "Calista Kibler",
    "Hue Cain",
    "Kathryn Carbone",
    "Royal Zemlicka",
    "Modesta Sutterfield",
    "Laure Kilduff",
    "Leonard Sickler",
    "Tonisha Jacobi",
    "Staci Kibbe",
    "Elenore Mcveigh",
    "Lauralee Crocket",
    "Hang Kelleher",
    "Coy Wadlington",
    "Soon Knoblock",
    "Brian Stirling",
    "Nakesha Dyment",
    "Ailene Augustyn",
    "Annemarie Stecker",
    "Jenee William"]
    
    let greenColor = UIColor(red: 0.12, green: 0.6, blue: 0.0, alpha: 1.0)
    let magandaColor = UIColor(red: 0.78, green: 0.03, blue: 0.81, alpha: 1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MMPickerViewDelegate implementation
    
    func didSelectDate(date : NSDate){
        if self.selectedType == .SelectDOB{
            self.btnDOB.setTitle( self.NSDateToString(date), forState: .Normal)
        }
        else if self.selectedType == .SelectTime {
            self.btnTime.setTitle( self.NSDateToStringTime(date), forState: .Normal)
        }

        
    }
    
    func didSelectRow(index : Int){
        if self.selectedType == .SelectName{
            self.btnName.setTitle( self.names[index], forState: .Normal)
        }
        else if self.selectedType == .SelectNumber {
            self.btnNumber.setTitle( String(index), forState: .Normal)
        }
    }
    
    func titleForRowAtIndex(index : Int) -> String?{
        if self.selectedType == .SelectName{
            return self.names[index]
        }
        else if self.selectedType == .SelectNumber {
            return String(index)

        }

        return nil
    }
    
    func numberOfRowsInComponent() -> Int{
        if self.selectedType == .SelectName{
            return self.names.count
        }
        else if self.selectedType == .SelectNumber {
            return 10
        }
        
        return 0
    }
    
    
    
    
    
    
    func NSDateToString(date : NSDate) -> String{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let strDate = dateFormatter.stringFromDate(date)
        
        return strDate
    }
    
    
    func NSDateToStringTime(date : NSDate) -> String{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:m a, MMM dd, yyyy"
        let strDate = dateFormatter.stringFromDate(date)
        
        return strDate
    }
    
    
    @IBAction func SelectName(sender: UIButton) {
        self.selectedType = .SelectName
        MMPickerView.presentView(self, isDatePicker: false) { (titleLable, doneButton, pickerView, datePicker) -> Void in
            
            titleLable.text = "Select the Name below"
            doneButton.setTitle("Done", forState: .Normal)
            
        }
        
    }

    
    @IBAction func SelecDOB(sender: UIButton) {
        self.selectedType = .SelectDOB

        MMPickerView.presentView(self, isDatePicker: true) { (titleLable, doneButton, pickerView, datePicker) -> Void in
            
            titleLable.text = "Select Date of Birth"
            doneButton.setTitle("Select", forState: .Normal)
            datePicker.datePickerMode = UIDatePickerMode.Date

            doneButton.backgroundColor = UIColor.blueColor()
            titleLable.textColor =  UIColor.blueColor()
            
        }
        
    }
    
    
    @IBAction func SelectNumber(sender: UIButton) {
        self.selectedType = .SelectNumber

        MMPickerView.presentView(self, isDatePicker: false) { (titleLable, doneButton, pickerView, datePicker) -> Void in
            
            titleLable.text = "Pick your favourite Number"
            doneButton.setTitle("Pick", forState: .Normal)
            
            doneButton.backgroundColor = self.greenColor
            titleLable.textColor = self.greenColor
        }
        
    }
    
    @IBAction func SelectTime(sender: UIButton) {
        self.selectedType = .SelectTime
        
        MMPickerView.presentView(self, isDatePicker: true) { (titleLable, doneButton, pickerView, datePicker) -> Void in
            
            titleLable.text = "Pick the Time and Date"
            doneButton.setTitle("Pick", forState: .Normal)
            datePicker.datePickerMode = UIDatePickerMode.DateAndTime
            
            doneButton.backgroundColor = self.magandaColor
            titleLable.textColor = self.magandaColor
            
        }
        
    }
    
    


}

