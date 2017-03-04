//
//  AnimationChat.swift
//  AppForeverYoung
//
//  Created by Gennaro Mellone on 04/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation


class AnimationChat: WKInterfaceController {

    @IBOutlet var imageObject: WKInterfaceImage!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        imageObject.setImageNamed("message")
        WKInterfaceDevice.current().play(.notification)
        imageObject.startAnimatingWithImages(in: NSRange(location: 0, length: 9), duration: 2, repeatCount: 4)
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

}
