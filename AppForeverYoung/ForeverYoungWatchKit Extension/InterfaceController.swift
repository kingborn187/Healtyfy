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
        registerUserNotificationSettings()
        print("pronto")
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


// Notification Center Delegate
extension InterfaceController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        
        if response.notification.request.content.categoryIdentifier == "friendRequest" {
            // Handle the actions for the expired timer.
            print("enter in category: friendRequest")
            if response.actionIdentifier == "answer1" {
                // Invalidate the old timer and create a new one. . .
                print("enter in action accet")
                let result = DataBase.createFriendship(usernameElderly: "sergio", usernameRelative: "renato")
                if result == true {
                    print("amicizia aggiunta")
                } else {
                    print("amicizia non aggiunta")
                }
            }
            else if response.actionIdentifier == "answer2" {
                // Invalidate the timer. . .
                print("enter in action decline")
            }
        }
        else if response.notification.request.content.categoryIdentifier == "memorySaved" {
        
        }
        
        // Else handle actions for other notification types. . .
    }
    
}


// Notification Center
extension InterfaceController {
    
    func registerUserNotificationSettings() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
//                let answer1 = UNNotificationAction(identifier: "answer1", title: "ACCEPT", options: [])
//                let answer2 = UNNotificationAction(identifier: "answer2", title: "DECLINE", options: [])
//                let friendRequest = UNNotificationCategory(identifier: "friendRequest", actions: [answer1, answer2] , intentIdentifiers: [], options: [])
//                UNUserNotificationCenter.current().setNotificationCategories([friendRequest])
//                UNUserNotificationCenter.current().delegate = self
//              
//                
//                
//                let respost = UNNotificationAction(identifier: "view", title: "VIEW", options: [])
//                let memorySaved = UNNotificationCategory(identifier: "memorySaved", actions: [respost] , intentIdentifiers: [], options: [])
//                UNUserNotificationCenter.current().setNotificationCategories([memorySaved])
//                UNUserNotificationCenter.current().delegate = self
                
                print("ciaooooo!")
                // LEVARE
                let answerOne = UNNotificationAction(identifier: "ACCEPT", title: "OK", options: [.foreground])
                let answerTwo = UNNotificationAction(identifier: "DECLINE", title: "OK", options: [.foreground])
                let quizCategory = UNNotificationCategory(identifier: "quizCategory", actions: [answerOne, answerTwo], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([quizCategory])
            
                
                print("⌚️⌚️⌚️Successfully registered notification support")
            } else {
                print("⌚️⌚️⌚️ERROR: \(error?.localizedDescription)")
            }
        }
    }
}
