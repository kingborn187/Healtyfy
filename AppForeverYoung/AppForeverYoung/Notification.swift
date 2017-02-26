//
//  Notification.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 24/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import Foundation

class Notification {
    
    
    static func sendFiendshipRequest(name: String, surname: String) {
        let semaphore = DispatchSemaphore(value: 0);
        
        let URL_SAVE_TEAM = "http://localhost:8888/ServerPush/newspush.php"
        let requestUrl = URLRequest(url: URL(string: URL_SAVE_TEAM)!)
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            do {
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as?NSDictionary
                
                //parsing the json
                if myJSON != nil {
                   
                    
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        })
        //executing the task
        semaphore.signal();
        task.resume()
        semaphore.wait()
    }
    
    
}
