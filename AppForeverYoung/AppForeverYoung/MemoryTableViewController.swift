//
//  MemoryTableViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 02/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class MemoryTableViewController: UITableViewController {
    
    var memory = DataBase.getMemory()
    
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
        return memory.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellMemory"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MemoryTableViewCell
        
        //let keys = Array(self.memory.keys)
        //let key = keys[indexPath.row]
        cell.titleMemory.text = memory[indexPath.row].titleMemory
        cell.dateMemory.text = memory[indexPath.row].dateMemory
        cell.timeMemory.text = memory[indexPath.row].timeMemory
        
        cell.imageMemory.contentMode = .scaleAspectFit
        downloadImage(url: URL(string: ("http://kingborn187.altervista.org/AppForeverYoung/MemoryService/api/"+"3385025964"+cell.titleMemory.text!+".png"))!, imageView: cell.imageMemory)
        
        print("http://kingborn187.altervista.org/AppForeverYoung/MemoryService/api/"+"3385025964"+cell.titleMemory.text!+".png")

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



