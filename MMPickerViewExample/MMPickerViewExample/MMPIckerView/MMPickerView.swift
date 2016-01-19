//
//  MMPickerView.swift
//  LatinPlaces
//
//  Created by Mohsin on 17/01/2016.
//
//

import UIKit


@objc protocol MMPickerViewDelegate{
    func didSelectDate(date : NSDate)
    func didSelectRow(index : Int)
    optional func titleForRowAtIndex(index : Int) -> String?
    func numberOfRowsInComponent() -> Int
    
    
}




class MMPickerView : UIView, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var btnDone: UIButton!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    
    
    private static var shareView = NSBundle.mainBundle().loadNibNamed("MMPickerView", owner: nil, options: nil)[0] as! MMPickerView
    private var delegate : MMPickerViewDelegate?
    private var bgView : UIView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "backgroundColor" {
            self.underlineView.backgroundColor = self.btnDone.backgroundColor
        }
    }


    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if self.delegate != nil {
            return self.delegate!.numberOfRowsInComponent()
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return self.delegate?.titleForRowAtIndex?(row)
    }
    
    
    
    
    
    class func presentView(viewController : UIViewController, isDatePicker : Bool, configureBlock : (titleLable : UILabel, doneButton : UIButton, pickerView : UIPickerView, datePicker : UIDatePicker)->Void){
        
        // add obser for underline color
        MMPickerView.shareView.btnDone.addObserver(MMPickerView.shareView, forKeyPath: "backgroundColor", options: NSKeyValueObservingOptions.New, context: nil)

        
        configureBlock(titleLable: MMPickerView.shareView.lblTitle, doneButton: MMPickerView.shareView.btnDone, pickerView: MMPickerView.shareView.pickerView, datePicker: MMPickerView.shareView.datePicker)

        
        viewController.view.endEditing(true)
        
        MMPickerView.shareView.delegate = viewController as? MMPickerViewDelegate
        
        MMPickerView.shareView.pickerView.hidden = isDatePicker
        MMPickerView.shareView.datePicker.hidden = !MMPickerView.shareView.pickerView.hidden
        if !isDatePicker{
            MMPickerView.shareView.pickerView.reloadComponent(0)
        }
        
        MMPickerView.shareView.frame.size.width = viewController.view.frame.width
        let view = UIView(frame: viewController.view.frame)
        MMPickerView.shareView.bgView = view
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        view.hidden = false
        view.alpha = 0.0
        viewController.view.addSubview(view)
        viewController.view.bringSubviewToFront(view)
        MMPickerView.shareView.frame.origin.y = viewController.view.frame.height
        
        let tapGesture = UITapGestureRecognizer(target: MMPickerView.shareView, action: "tapOnView:")
        view.addGestureRecognizer(tapGesture)
        
        viewController.view.addSubview(MMPickerView.shareView)
        viewController.view.bringSubviewToFront(MMPickerView.shareView)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            view.alpha = 1.0
            MMPickerView.shareView.frame.origin.y = MMPickerView.shareView.frame.origin.y - MMPickerView.shareView.frame.height
            
            }) { (success) -> Void in
                
        }
        
        
    }
    
    
    
    
    private class func removeView(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            MMPickerView.shareView.bgView?.alpha = 0.0
            MMPickerView.shareView.frame.origin.y = MMPickerView.shareView.frame.origin.y + MMPickerView.shareView.frame.height
            
            }) { (success) -> Void in
                MMPickerView.shareView.bgView?.removeFromSuperview()
        }
    }
    
    
    class func instanceFromNib() -> MMPickerView {
        return  NSBundle.mainBundle().loadNibNamed("View", owner: nil, options: nil)[0] as! MMPickerView
        
    }
    
    
    func tapOnView(gesture: UITapGestureRecognizer){
        MMPickerView.removeView()
        
    }
    
    
    
    
    @IBAction func doneBtn(sender: UIButton) {
        if MMPickerView.shareView.datePicker.hidden {
            self.delegate?.didSelectRow(self.pickerView.selectedRowInComponent(0))
        }
        else {
            self.delegate?.didSelectDate(self.datePicker.date)
        }
        
        MMPickerView.removeView()
        
    }
    
    
}


