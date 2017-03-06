//
//  GoodMorningInterfaceController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 06/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation


class GoodMorningInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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

    @IBAction func SmileAction() {
        presentController(withName: "prova", context: nil)
    }
}
