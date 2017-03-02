//
//  ChatInterfaceController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 03/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import WatchKit
import Foundation


class ChatInterfaceController: WKInterfaceController {

    
    @IBOutlet var tableView: WKInterfaceTable!
    
    let chat = DataBase.getChat()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        tableView.setNumberOfRows(chat.count, withRowType: "ChatRows")
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
        for i in 0 ... chat.count {
            if let row = tableView.rowController(at: i) as? ChatRow {
                row.query.setText(chat[i].message)
                downloadImage(url: URL(string: ("http://kingborn187.altervista.org/AppForeverYoung/UserService/api/"+chat[i].sender+".jpg"))!, imageView: row.image)
                print("http://kingborn187.altervista.org/AppForeverYoung/UserService/api/"+chat[i].sender+".jpg")
            }
        }
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imageView: WKInterfaceImage) {
        print("Download Started")
        
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                imageView.setImage(UIImage(data: data))
            }
        }
    }
    
}

