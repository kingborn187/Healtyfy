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
 
    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        let notificationBody = notification.request.content.body
        label.setText(notificationBody)
        
        if let imageAttchment = notification.request.content.attachments.first {
            let imageUrl = imageAttchment.url
            let imageData = try! Data(contentsOf: imageUrl)
            let newImage = UIImage(data: imageData)
            image.setImage(newImage)
        } else {
            self.image.setImageNamed("unknown")
        }
        completionHandler(.custom)
    }
}
