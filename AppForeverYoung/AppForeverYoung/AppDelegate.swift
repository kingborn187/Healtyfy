//
//  AppDelegate.swift
//  PushPizzaDemo
//
//  Created by Steven Lipton on 1/2/17.
//  Copyright © 2017 Steven Lipton. All rights reserved.
//

import UIKit
import UserNotifications

var token = ""


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Check if you have permission to use notifications.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        registerUserNotificationSettings()
        return true
    }
    
    
    //code to make a token string
    func tokenString(_ deviceToken:Data) -> String{
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format: "%02x",byte)
        }
        return token
    }
    
    
    // Successful registration and you have a token. Send the token to your provider, in this case the console for cut and paste.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("Successful registration. Token is:")
        token = tokenString(deviceToken)
        print(token)
    }
    
    
    // Failed registration. Explain why.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Prova")
    }
}


// Notification Center Delegate
extension AppDelegate: UNUserNotificationCenterDelegate {
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
                print("enter in action accept")
                let result = DataBase.createFriendship(usernameElderly: globalUsername, usernameRelative: "renato")
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
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [response.notification.request.identifier])
            print("memory aggiunta")
            
            if response.actionIdentifier == "view" {
                print("enter in action view")
            }
        }
    }
}


// Notification Center
extension AppDelegate {
    
    func registerUserNotificationSettings() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let answer1 = UNNotificationAction(identifier: "answer1", title: "ACCEPT", options: [.foreground])
                let answer2 = UNNotificationAction(identifier: "answer2", title: "DECLINE", options: [.foreground])
                let friendRequest = UNNotificationCategory(identifier: "friendRequest", actions: [answer1, answer2] , intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([friendRequest])
                UNUserNotificationCenter.current().delegate = self
                
                let respost = UNNotificationAction(identifier: "view", title: "VIEW", options: [])
                let memorySaved = UNNotificationCategory(identifier: "memorySaved", actions: [respost] , intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([memorySaved])
                
                
                
                
                
                UNUserNotificationCenter.current().delegate = self
                
                print("⌚️⌚️⌚️Successfully registered notification support")
            } else {
                print("⌚️⌚️⌚️ERROR: \(error?.localizedDescription)")
            }
        }
    }
}
