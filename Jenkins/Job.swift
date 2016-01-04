//
//  Job.swift
//  Jenkins
//
//  Created by Tayal, Rishabh on 1/4/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class Job: NSObject {
    
    var color: String!
    var name: String!
    var url: String!
    
    init(dictionary: Dictionary<String, AnyObject>) {
        color = dictionary["color"] as! String
        name = dictionary["name"] as! String
        url = dictionary["url"] as! String
    }
}
