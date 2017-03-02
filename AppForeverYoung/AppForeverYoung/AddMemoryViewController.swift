//
//  AddMemoryViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 27/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class AddMemoryViewController: UIViewController {

    @IBOutlet var titleMemory: UITextField!
    @IBOutlet var bodyMemory: UITextField!
    @IBOutlet var dateMemory: UITextField!
    @IBOutlet var timeMemory: UITextField!
    @IBOutlet var imageMemory: UIImageView!
    
    let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let result = DataBase.createMemory(telephone: "3385025964", titleMemory: titleMemory.text!, bodyMemory: bodyMemory.text!, dateMemory: dateMemory.text!, timeMemory: timeMemory.text!, imageMemory: imageMemory.image!)
        
        if result {
            serviceManager.send(msg: "memory by relatives", usernameRequest: globalUsername)
            let alertController = UIAlertController(title: "Registration memory send", message: "You have successfully send a registartion memory", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
               
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "No registration memory", message: "You don't have send successfully a memory", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }

}
