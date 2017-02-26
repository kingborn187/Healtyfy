//
//  PersonasTableViewController.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 24/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class PersonasTableViewController: UITableViewController {
    
    var personas = DataBase.getPersonas()
    
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
        return personas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PersonasTableViewCell
        
        let keys = Array(self.personas.keys)
        let key = keys[indexPath.row]
        cell.telephone.text = key
        cell.name.text = personas[key]?.name
        cell.surname.text = personas[key]?.surname
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectPerson" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let keys = Array(self.personas.keys)
                let key = keys[indexPath.row]
                let destinationController = segue.destination as! RealtivesMenuViewController
                destinationController.name = (personas[key]?.name)!
                destinationController.surname = (personas[key]?.surname)!
            }
        }
    }
    
}
