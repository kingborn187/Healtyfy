//
//  InterfaceController.swift
//  ForeverYoungWatchKit Extension
//
//  Created by Renato Tramontano on 24/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        print("pronto")
        registerUserNotificationSettings()
        scheduleLocalNotification()
    }
    
    

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        print("pronto3")
    }
    
}


extension Int {
    static func randomInt(_ min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}

extension InterfaceController {
    
    func registerUserNotificationSettings() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let viewCatsAction = UNNotificationAction(identifier: "viewCatsAction", title: "OK", options: .foreground)
                //let viewCatsAction1 = UNNotificationAction(identifier: "viewCatsAction1", title: "I'm not very well", options: .foreground)
                let pawsomeCategory = UNNotificationCategory(identifier: "Pawsome", actions: [viewCatsAction], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([pawsomeCategory])
                UNUserNotificationCenter.current().delegate = self
                print("⌚️⌚️⌚️Successfully registered notification support")
            } else {
                print("⌚️⌚️⌚️ERROR: \(error?.localizedDescription)")
            }
        }
    }
    
    func scheduleLocalNotification() {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.alertSetting == .enabled {
        
                let catImageURL = Bundle.main.url(forResource: "insulina", withExtension: "jpg")
                let notificationAttachment = try! UNNotificationAttachment(identifier: "Pawsome4", url: catImageURL!, options: nil)
                
                let notificationContent = UNMutableNotificationContent()
                notificationContent.title = "Memory"
                notificationContent.subtitle = "It's <11:24>"
                notificationContent.body = "Hello "
                notificationContent.categoryIdentifier = "Pawsome"
                notificationContent.attachments = [notificationAttachment]
                
                var date = DateComponents()
                date.minute = 30
                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let notificationRequest = UNNotificationRequest(identifier: "Pawsome32", content: notificationContent, trigger: notificationTrigger)
                
                UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                    if let error = error {
                        print("⌚️⌚️⌚️ERROR:\(error.localizedDescription)")
                    } else {
                        print("⌚️⌚️⌚️Local notification was scheduled")
                    }
                }
            } else {
                print("⌚️⌚️⌚️Notification alerts are disabled")
            }
        }
    }
}

// Notification Center Delegate
extension InterfaceController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        print("waakakaka")
        //presentController(withName: "ModifierMenu", context: nil)
    }
}
