//
//  ViewController.swift
//  TipCalculator1
//
//  Created by robin on 9/25/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billValue: UITextField!
    
    @IBOutlet weak var percent: UISegmentedControl!
    
    @IBOutlet weak var plusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the possition of views
        self.percent.center = CGPoint (x: 160, y: 0)
        self.billValue.center = CGPoint (x: 160, y: 0)
        self.tipLabel.center = CGPoint (x: 204, y: 0)
        self.totalLabel.center = CGPoint (x: 160, y: 0)
        self.plusLabel.center = CGPoint (x: 54, y: 0)
        
        // do the animation for these views
        UIView.animateWithDuration(2, animations:{
            self.percent.center = CGPoint (x: 160, y:322)
            self.billValue.center = CGPoint (x: 160, y: 112)
            self.tipLabel.center = CGPoint (x: 204, y: 183)
            self.totalLabel.center = CGPoint (x: 160, y: 283)
            self.plusLabel.center = CGPoint (x: 54, y: 183)
        })
        
        // focus on the billValue after finishing animation
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 4 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.billValue.becomeFirstResponder()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapDisable(sender: AnyObject) {
    //print("hello")
        view.endEditing(true)
    }

    @IBAction func billProcess(sender: AnyObject) {
        
        saveValue()
        
        let tipPercent = [0.18, 0.2, 0.25]
        let bill = Double(billValue.text!) ?? 0
        
        // calculate tip and total
        let tip:Double = bill * tipPercent[percent.selectedSegmentIndex]
        let total:Double = bill + tip
        
        // format the lables
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // load the selected segment index from settings view
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("percentDef")
        percent.selectedSegmentIndex = intValue
        
        // repeat the billProcess function when go back from the settings view
        let tipPercent = [0.18, 0.2, 0.25]
        let bill = Double(billValue.text!) ?? 0
        let tip:Double = bill * tipPercent[percent.selectedSegmentIndex]
        let total:Double = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func saveValue() {
        let saveValue = NSUserDefaults.standardUserDefaults()
        saveValue.setObject(billValue.text, forKey: "billValue")
        saveValue.setObject(NSDate(), forKey: "billTime")
        saveValue.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let billTimeLoaded = NSUserDefaults.standardUserDefaults().objectForKey("billTime") as? NSDate
        if(billTimeLoaded != nil && integer_t(NSDate().timeIntervalSinceDate(billTimeLoaded!)) < 600){
            billValue.text = NSUserDefaults.standardUserDefaults().objectForKey("billValue") as? String
        }
        
    }
    
}

