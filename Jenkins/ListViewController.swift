//
//  ListViewController.swift
//  Jenkins
//
//  Created by Tayal, Rishabh on 1/4/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    enum SectionType: Int {
        case Queue
        case Jobs
        case Count
    }
    
    var jobsArray: [Job] = []
    var queueArray: [Queue] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
        BackendUtil.getJobs { (result, error) -> Void in
            if let result = result as? Dictionary<String, AnyObject> {
                self.jobsArray = []
                for job in result["jobs"] as! Array<Dictionary<String, AnyObject>> {
                    let jobObj = Job(dictionary: job)
                    self.jobsArray.append(jobObj)
                }
                self.tableView.reloadData()
            }
        }
        
        BackendUtil.getQueue { (result, error) -> Void in
            if let result = result as? Dictionary<String, AnyObject> {
                print(result)
                self.queueArray = []
                for queue in result["items"] as! Array<Dictionary<String, AnyObject>> {
                    let queueObj = Queue(dictionary: queue)
                    self.queueArray.append(queueObj)
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SectionType.Count.rawValue
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == SectionType.Jobs.rawValue {
            return "Jobs"
        }
        if section == SectionType.Queue.rawValue {
            return "Queue"
        }
        return ""
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SectionType.Jobs.rawValue {
            return jobsArray.count
        }
        if section == SectionType.Queue.rawValue {
            return queueArray.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if indexPath.section == SectionType.Jobs.rawValue {
            cell?.textLabel?.text = jobsArray[indexPath.row].name
        }
        return cell!
    }
}