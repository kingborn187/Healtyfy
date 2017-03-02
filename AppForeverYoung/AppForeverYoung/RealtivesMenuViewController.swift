//
//  RealtivesMenuViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 26/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class RealtivesMenuViewController: UIViewController {
    
    @IBOutlet var imagePerson: UIImageView!
    @IBOutlet var namePerson: UILabel!
    @IBOutlet var surnamePerson: UILabel!
    
    var name = ""
    var surname = ""
    var image = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        namePerson.text = name
        surnamePerson.text = surname
        imagePerson.image = image.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

}
