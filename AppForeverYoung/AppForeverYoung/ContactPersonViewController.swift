//
//  ContactPersonViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 24/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class ContactPersonViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var typeQuestionPicker: UIPickerView!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var riquadro1: UIImageView!
    
    //let typeQuestion = ["How are you?", "Do you have a lunch?", "Are you alone?", "Are you at home?"]
    let typeQuestion = DataBase.getQuestions()
    var question = String()
    let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        riquadro1.layer.cornerRadius = 15
        riquadro1.layer.masksToBounds = true
        riquadro1.layer.borderWidth = 2.0
        riquadro1.layer.borderColor = UIColor(hue: 0.7222, saturation: 0, brightness: 1, alpha: 0.25).cgColor
        
        print(question)
        label.text = question
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: typeQuestion[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeQuestion.count
        
    }
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeQuestion[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        question = typeQuestion[row]
        viewDidLoad()
    }
    
    
    
    @IBAction func sendAction(_ sender: Any) {
        if question == "" {
            let alertController = UIAlertController(title: "Error", message: "Nathing question i selected", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            DataBase.createChat(sender: globalTelephone, consignee: globarControlTelephone, message: self.label.text!)
            DataBase.createNotification(sender: globalTelephone, consignee: globarControlTelephone, message: "Message")
            serviceManager.send(msg: "message by relatives", usernameRequest: globalUsername)
            let alertController = UIAlertController(title: "Question send", message: "the question \"\(question)\" is send", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action:UIAlertAction) in
                self.performSegue(withIdentifier: "backToMenuRel", sender: self)}))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
}

