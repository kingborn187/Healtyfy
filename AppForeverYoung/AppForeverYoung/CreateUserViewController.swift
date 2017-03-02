//
//  CreateUserViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 17/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var typePersonPicker: UIPickerView!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var surname: UITextField!
    @IBOutlet var telephone: UITextField!
    @IBOutlet var buttonImagePerson: UIButton!
    @IBOutlet var imagePerson: UIImageView!
    
    let typePerson = ["Elderly", "Relative"]
    var person = String()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        person = typePerson[0]
        
        username.delegate = self
        password.delegate = self
        name.delegate = self
        surname.delegate = self
        telephone.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Solleva la view quando mostra la tastier
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2-50
            }
        }
    }
    
    // Riabassa la view quando la teatsiera sparisce
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/2-50
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide keyboard when user touches outside kebord
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typePerson.count
    }
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typePerson[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        person = typePerson[row]
    }
    
    
    @IBAction func createAction(_ sender: Any) {
        let result = DataBase.createUser(username: username.text!, password: password.text!, name: name.text!, surname: surname.text!, telephone: telephone.text!, type: person, imagePerson: imagePerson.image!)
        
        if result {
            let alertController = UIAlertController(title: "Successfully performed registration", message: "You have enrolled successfully", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  {(action:UIAlertAction) in
                self.performSegue(withIdentifier: "returnMain", sender: self)}))
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "No successfully performed registration", message: "You don't have enrolled successfully", preferredStyle: UIAlertControllerStyle.alert)
                
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:  nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func controlUsername(_ sender: Any) {
        let result = DataBase.controlUsername(username: username.text!)
        
        if result == true {
            username.text = ""
            username.attributedPlaceholder = NSAttributedString(string:"existing username", attributes:[NSForegroundColorAttributeName: UIColor.red])
        }
    }
    
    @IBAction func controlTelephone(_ sender: Any) {
        let result = DataBase.controlTelephone(telephone: telephone.text!)
        
        if result == true {
            telephone.text = ""
            telephone.attributedPlaceholder = NSAttributedString(string:"existing telephone", attributes:[NSForegroundColorAttributeName: UIColor.red])
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
        imagePerson.contentMode = .scaleAspectFit
        imagePerson.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
  
}
