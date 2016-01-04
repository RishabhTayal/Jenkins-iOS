//
//  ListViewController.swift
//  Jenkins
//
//  Created by Tayal, Rishabh on 1/4/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var dataArray: [Job] = []
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSUserDefaults.standardUserDefaults().stringForKey(HostBaseURLKey)
        BackendUtil.getWith(url!) { (result, error) -> Void in
            if let result = result as? Dictionary<String, AnyObject> {
                print(result)
                self.dataArray = []
                for job in result["jobs"] as! Array<Dictionary<String, AnyObject>> {
                    let jobObj = Job(dictionary: job)
                    self.dataArray.append(jobObj)
                }
                self.tableView.reloadData()
            }
        }        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = dataArray[indexPath.row].name
        return cell!
    }
}