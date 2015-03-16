//
//  ViewController.swift
//  SwiftEverlive
//
//  Created by Tony on 21/09/2014.
//  Copyright (c) 2014 dobrev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myApiKey:NSString = "YOUR_API_KEY"
        Everlive.setApplicationKey(myApiKey)
        
        // create an activity
        var myActivity = Activities() // curently we need to declare the models in Objective-C but can use them as in Swift. Data models created with Swift are not properly mapped to the server entities
        myActivity.text = "Now coding in Swift"
        
        var ds:EVDataStore = EVDataStore.sharedInstance() as EVDataStore
        ds.create(myActivity) { (result:Bool, error:NSError!) -> Void in
            if(result) {
                println("Success")
            } else {
                println("Failed to create activity: " + error.domain)
            }
        }

        // retrieve all activities
        Activities.fetchAll {(activities:Array!, error:NSError!) -> Void in
            if(error != nil) {
                println("Failed to retrieve activities: " + error.domain)
            } else {
                for item in activities {
                    var activity = item as Activities
                     println("Activity's text: '\(activity.text)', Created at \(activity.createdAt)")
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

