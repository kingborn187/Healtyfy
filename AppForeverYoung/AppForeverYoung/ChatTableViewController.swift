//
//  ChatTableViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 02/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController {
    
    var chat = DataBase.getChat()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chat.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellChat"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatTableViewCell
        
        cell.labelChat.text = chat[indexPath.row].message
      
        //cell.imageChat.contentMode = .scaleAspectFit
        downloadImage(url: URL(string: ("http://kingborn187.altervista.org/AppForeverYoung/UserService/api/"+chat[indexPath.row].sender+".jpg"))!, imageView: cell.imageChat)
        
        print("http://kingborn187.altervista.org/AppForeverYoung/UserService/api/"+chat[indexPath.row].sender+".jpg")
        
        return cell
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
}



