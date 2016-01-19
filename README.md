# MMPickerView

<img src="https://github.com/mmohsin991/MMPickerView/blob/master/MMPickerView.gif" alt="How to use">

# Introduction: 
MMPickerView use for pick the item from an array or select date using MMPickerView very easily.

# How to use:
You just need to call following method and the rest will do by MMPickerView

    MMPickerView.presentView(self, isDatePicker: false) { (titleLable, doneButton, pickerView, datePicker) -> Void in
    
    }
        
Then you need to confirm the protocol "MMPickerViewDelegate" for delegate methods,

Define the delegate methods of "MMPickerViewDelegate" as per your requirments.

    func didSelectDate(date : NSDate)                  // Called when date or time is selected.
    func didSelectRow(index : Int)                     // Called when item is selected.
    func numberOfRowsInComponent() -> Int              // Called for acquiring the number of item to be load in MMPickerView. 
    func titleForRowAtIndex(index : Int) -> String?    // Called every time for each item to set title.
    
# Custumization:
You can change the attibute of MMPickerView, it has the callback block where you have full access of UIPickerView,
UIDatePicker, Title Lable of MMPickerView and Done Button of MMPickerView.
    
Here is the Example code:

Present the DatePicker

      MMPickerView.presentView(self, isDatePicker: true) { (titleLable, doneButton, pickerView, datePicker) -> Void in
            
            titleLable.text = "Pick your favourite number"
            doneButton.setTitle("Pick", forState: .Normal)
            datePicker.datePickerMode = UIDatePickerMode.DateAndTime
            
            doneButton.backgroundColor = self.magandaColor
            titleLable.textColor = self.magandaColor
            
        }
        
Present the PickerView

        MMPickerView.presentView(self, isDatePicker: false) { (titleLable, doneButton, pickerView, datePicker) -> Void in
            
            titleLable.text = "Pick your favourite number"
            doneButton.setTitle("Pick", forState: .Normal)
            
            doneButton.backgroundColor = self.greenColor
            titleLable.textColor = self.greenColor
        }
        
# Thank You.
