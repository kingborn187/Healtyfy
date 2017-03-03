//
//  NotificationInterfaceController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 03/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation


class NotificationInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    let notification = DataBase.getNotification()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        tableView.setNumberOfRows(notification.count, withRowType: "NotificationRows")
        setupTable()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setupTable() {
        print(notification.count)
        for i in 0 ... notification.count {
            if let row = tableView.rowController(at: i) as? NotificationRow {
                row.message.setText(notification[i].message)
                row.sender.setText(notification[i].sender)
                row.date.setText(notification[i].date)
                row.imageNot.setImage(UIImage(named: notification[i].message))
            }
        }
    }
}

