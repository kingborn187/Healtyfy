//
//  FriedRequestNotificationController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 28/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class FriedRequestNotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var label: WKInterfaceLabel!
    
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
 
}
