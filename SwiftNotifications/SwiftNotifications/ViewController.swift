//
//  ViewController.swift
//  SwiftNotifications
//
//  Created by Tony on 20/09/2014.
//  Copyright (c) 2014 com.dobrev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // schedule notification
        var dateComponents:NSDateComponents = NSDateComponents()
        dateComponents.year = 2014
        dateComponents.month = 09
        dateComponents.day = 20
        dateComponents.hour = 23
        dateComponents.minute = 13
        dateComponents.timeZone = NSTimeZone.systemTimeZone()
    
        var calendar:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var date:NSDate!! = calendar.dateFromComponents(dateComponents)
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hello notifications"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        // We are posting the actions to the notification center - add event observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"drawAShape", name: "firstActionTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showAMessage", name: "secondActionTapped", object: nil)

    }

    func drawAShape(){
        var view:UIView = UIView(frame: CGRectMake(10, 10, 100, 100))
        view.backgroundColor = UIColor.redColor()
        self.view.addSubview(view)
    }
    
    func showAMessage(){
        var view:UIView = UIView(frame: CGRectMake(10, 10, 100, 100))
        view.backgroundColor = UIColor.redColor()

        var alertMessageController:UIAlertController = UIAlertController(title: "Notification App", message: "Hello notifications", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertMessageController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertMessageController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

