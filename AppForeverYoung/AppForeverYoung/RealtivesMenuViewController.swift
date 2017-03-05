//
//  RealtivesMenuViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 26/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

var name = ""
var surname = ""
var imagex = ""

class RealtivesMenuViewController: UIViewController {
    
    @IBOutlet var imagePerson: UIImageView!
    @IBOutlet var namePerson: UILabel!
    @IBOutlet var surnamePerson: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imagex != "" {
            downloadImage(url: URL(string: imagex)!, imageView: imagePerson)
            self.imagePerson.layer.cornerRadius = self.imagePerson.frame.size.width / 2
            self.imagePerson.clipsToBounds = true
            namePerson.text = name
            surnamePerson.text = surname
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imageView: UIImageView) {
        print("Download Started")
        
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                imageView.image = UIImage(data: data)
            }
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
}
