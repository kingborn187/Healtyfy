//
//  AddMemoryViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 27/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class AddMemoryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate {

    @IBOutlet var titleMemory: UITextField!
    @IBOutlet var bodyMemory: UITextField!
    @IBOutlet var dateMemory: UITextField!
    @IBOutlet var timeMemory: UITextField!
    @IBOutlet var imageMemory: UIImageView!
    @IBOutlet weak var SendMemoryButton: UIButton!
    
    let serviceManager = ServiceManager()
    let picker = UIImagePickerController()
    var datePickerView:UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SendMemoryButton.layer.borderWidth = 1.0
        SendMemoryButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).cgColor
        SendMemoryButton.layer.cornerRadius = 10
        
        picker.delegate = self
        // Do any additional setup after loading the view.
        timeMemory.delegate = self
        bodyMemory.delegate = self
        dateMemory.delegate = self
        timeMemory.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide keyboard when user touches outside kebord
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let result = DataBase.createMemory(telephone: globalTelephone, titleMemory: titleMemory.text!, bodyMemory: bodyMemory.text!, dateMemory: dateMemory.text!, timeMemory: timeMemory.text!, imageMemory: imageMemory.image!)
        
        if result {
            Notification.sendMemory(name: "", surname: "", token: "")
            serviceManager.send(msg: "memory by relatives", usernameRequest: globalUsername)
            DataBase.createNotification(sender: globalTelephone, consignee: globarControlTelephone, message: "Memory")
            let alertController = UIAlertController(title: "Registration memory send", message: "You have successfully send a registartion memory", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                self.performSegue(withIdentifier: "returnMainRelatives", sender: self)
            }))
        
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "No registration memory", message: "You don't have send successfully a memory", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func addImageFromLibrary(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //imageMemory.contentMode = .scaleAspectFit
        imageMemory.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    
    @IBAction func selectDate(_ sender: UITextField) {
        // Data Picker
        self.datePickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        datePickerView.backgroundColor = UIColor.white
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        // Tool Bar
        let toolBar = UIToolbar()
        toolBar.barStyle = .blackOpaque
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 255/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.dateMemory?.inputAccessoryView = toolBar
        
        
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
   
    
    func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateMemory?.text = dateFormatter1.string(from: datePickerView.date)
        self.dateMemory?.resignFirstResponder()
    }
    
    
    func cancelClick() {
        self.dateMemory?.resignFirstResponder()
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateMemory?.text = dateFormatter.string(from: sender.date)
        
    }
    
    @IBAction func selectTime(_ sender: UITextField) {
        // Data Picker
        self.datePickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        datePickerView.backgroundColor = UIColor.white
        datePickerView.datePickerMode = UIDatePickerMode.time
        
        // Tool Bar
        let toolBar = UIToolbar()
        toolBar.barStyle = .blackOpaque
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 255/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick2))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick2))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.timeMemory?.inputAccessoryView = toolBar
        
        
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged2), for: .valueChanged)
    }
  
    
    func doneClick2() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .none
        dateFormatter1.timeStyle = .short
        timeMemory?.text = dateFormatter1.string(from: datePickerView.date)
        self.timeMemory?.resignFirstResponder()
    }
    
    
    func cancelClick2() {
        self.timeMemory?.resignFirstResponder()
    }
    
    func datePickerValueChanged2(sender:UIDatePicker) {
        
        let dateFormatter =  DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.short
        timeMemory?.text = dateFormatter.string(from: sender.date)
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }

}
