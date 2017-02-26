//
//  AppDelegate.swift
//  PushPizzaDemo
//
//  Created by Steven Lipton on 1/2/17.
//  Copyright © 2017 Steven Lipton. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Check if you have permission to use notifications.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) {
            (granted,error) in
            if granted{
                application.registerForRemoteNotifications()
            } else {
                print("User Notification permission denied: \(error?.localizedDescription)")
            }
        }
        
        let answer1 = UNNotificationAction(identifier: "answer1", title: "ACCEPT", options: [.foreground])
        let answer2 = UNNotificationAction(identifier: "answer2", title: "DECLINE", options: [.foreground])
        let friendRequest = UNNotificationCategory(identifier: "friendRequest", actions: [answer1, answer2] , intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([friendRequest])
        
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
        print(tokenString(deviceToken))
    }
    
    
    // Failed registration. Explain why.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
}
