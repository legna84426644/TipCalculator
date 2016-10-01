//
//  SettingsViewController.swift
//  TipCalculator1
//
//  Created by robin on 9/26/16.
//  Copyright © 2016 robin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var percentDef: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //print("save the setting")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(percentDef.selectedSegmentIndex, forKey: "percentDef")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("load the setting")
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("percentDef")
        percentDef.selectedSegmentIndex = intValue
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
