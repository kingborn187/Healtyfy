//
//  AddPersonViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 18/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit
import UserNotifications

class AddPersonViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    
    var person: (name: String, surname: String)? = ("", "")
    var find = false
    let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = person?.name
        surnameLabel.text = person?.surname
        
        serviceManager.delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var telephone: UITextField!
    @IBAction func findPhone(_ sender: Any) {
        person = DataBase.findPersonWithPhone(telephone: telephone.text!)
        
        if let persona = person {
            self.nameLabel.text = persona.name
            self.surnameLabel.text = persona.surname
            find = true
        } else {
            let alertController = UIAlertController(title: "Error", message: "The person you are looking for does not exist", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  nil))
            present(alertController, animated: true, completion: nil)
            find = false
        }
        viewDidLoad()
    }
    
    @IBAction func AddAction(_ sender: Any) {
        if find {
            Notification.sendFiendshipRequest(name: "renato", surname: "tramontano", token: token)
            serviceManager.send(msg: "friendship request", usernameRequest: globalUsername)
            let alertController = UIAlertController(title: "Request send", message: "The friend request has been sent", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  nil))
            present(alertController, animated: true, completion: nil)
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "No person listed", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func showMessage(msg: String) {
        let alertController = UIAlertController(title: "Friend request accepted", message: "the friend request has been accepted", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        print(msg)
    }
    
}

extension AddPersonViewController: ServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            print("Connections: \(connectedDevices)")
        }
    }
    
    func communicatesMessage(manager: ServiceManager, message: String) {
        OperationQueue.main.addOperation {
            print("hello")
            switch message {
            case "friendship accepted":
                self.showMessage(msg: "Mesaggio ricevuto")
                
            default:
                NSLog("%@", "Unknown message value received: \(message)")
            }
        }
    }
    
}
