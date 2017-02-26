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
    
    let typeQuestion = ["How are you?", "Do you have a lunch?", "Are you alone?", "Are you at home?"]
    var question = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let alertController = UIAlertController(title: "Question send", message: "the question \"\(question)\" is send", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
}
