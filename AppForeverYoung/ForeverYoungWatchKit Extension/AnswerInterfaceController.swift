//
//  AnswerInterfaceController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 05/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation

var query = ""
var ricevent = ""
var sender = ""

class AnswerInterfaceController: WKInterfaceController {

    @IBOutlet var ans1: WKInterfaceButton!
    @IBOutlet var ans2: WKInterfaceButton!
    
    let answers = DataBase.getAnswer(message: query)
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
         print("->"+query)
        ans1.setTitle(answers[0])
        ans2.setTitle(answers[1])
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

    @IBAction func sendMessage1() {
        DataBase.createChat(sender: sender, consignee: ricevent, message: answers[0])
        DataBase.createNotification(sender: sender, consignee: ricevent, message: "Answer")
    }
    
    @IBAction func sendMessage2() {
        DataBase.createChat(sender: sender, consignee: ricevent, message: answers[1])
        DataBase.createNotification(sender: sender, consignee: ricevent, message: "Answer")
    }
}
