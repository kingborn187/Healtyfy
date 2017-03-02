//
//  MemoryInterfaceController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 02/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation


class MemoryInterfaceController: WKInterfaceController {
    
//    @IBOutlet var title: WKInterfaceLabel!
    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var time: WKInterfaceLabel!
    @IBOutlet var body: WKInterfaceLabel!
    
    
    var classMemory: [MemoryInterfaceController] = []

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        let memory = DataBase.getMemory()
        
//        for i in 0 ... memory.count {
//            classMemory[i].title.setText("ciao")
//        }
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
