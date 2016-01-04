//
//  ViewController.swift
//  Jenkins
//
//  Created by Tayal, Rishabh on 1/4/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = NSUserDefaults.standardUserDefaults().stringForKey(HostBaseURLKey) {
            textField.text = url
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goClicked(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(textField.text, forKey: HostBaseURLKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ListViewController") as! ListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

