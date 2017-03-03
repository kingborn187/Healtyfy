//
//  NotificationTableViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 03/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class NotificationTableViewController: UITableViewController {
    
    var notification = DataBase.getNotification()
    
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
        return notification.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NotificationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NotificationTableViewCell
        
        cell.imageNot.image = UIImage(named: notification[indexPath.row].message)
        cell.message.text = notification[indexPath.row].message
        cell.sender.text = notification[indexPath.row].sender
        cell.date.text = notification[indexPath.row].date
        
        return cell
    }
}



