//
//  BackendUtil.swift
//  Jenkins
//
//  Created by Tayal, Rishabh on 1/4/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class BackendUtil: NSObject {
    
    typealias CompletionBlock =  (result: AnyObject?, error: NSError?) -> Void
    
    static let baseURl = NSUserDefaults.standardUserDefaults().stringForKey(HostBaseURLKey)!
    
    class func getQueue(completion: CompletionBlock) {
        
        let url = baseURl + "/queue/api/json?pretty=true"
        getWith(url, completion: completion)
        
    }
    
    class func getJobs(completion: CompletionBlock) {
        let url = baseURl + "/api/json?pretty=true"
        getWith(url, completion: completion)
    }
    
    class func getWith(url: String, completion: CompletionBlock) {
        let request = NSMutableURLRequest(URL: (NSURL(string: url))!)
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request) { (d: NSData?, r: NSURLResponse?, e: NSError?) -> Void in
            if let data = d {
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    completeOnMainThread(completion, result: result, error: nil)
                } catch {
                    completeOnMainThread(completion, result: nil, error: nil)
                }
            } else {
                completeOnMainThread(completion, result: nil, error: e)
            }
            }.resume()
    }
    
    class func completeOnMainThread(completion: CompletionBlock, result: AnyObject?, error: NSError?) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            completion(result: result, error: error)
        }
    }
}
