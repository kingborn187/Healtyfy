
import UIKit
import UserNotifications

class ElderlyMenuViewController: UIViewController {
    
    let serviceManager = ServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        serviceManager.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showMessage(msg: String) {
        let alertController = UIAlertController(title: "Friend request", message: "you have received a request for amiciza by ...", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "DECLINE", style: UIAlertActionStyle.default, handler: nil))
        alertController.addAction(UIAlertAction(title: "ACCEPT", style: UIAlertActionStyle.default, handler:  {(action:UIAlertAction) in
            let result = DataBase.createFriendship(usernameElderly: globalUsername, usernameRelative: "renato")
            if result == true {
                print("amicizia aggiunta")
                self.serviceManager.send(msg: "friendship accepted", usernameRequest: globalUsername)
            }
        }));
        
        present(alertController, animated: true, completion: nil)
        print(msg)
    }
    
    
    func showAlert(msg: String) {
        let alertController = UIAlertController(title: "Message by relatives", message: "you have received a message by ...", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "READ LATER", style: UIAlertActionStyle.default, handler: nil))
        alertController.addAction(UIAlertAction(title: "READ NOW", style: UIAlertActionStyle.default, handler:  {(action:UIAlertAction) in
            self.performSegue(withIdentifier: "showChat", sender: self)}))
        present(alertController, animated: true, completion: nil)
        print(msg)
    }
    
    func showMemory(msg: String) {
        let alertController = UIAlertController(title: "Memory by relatives", message: "you have received a memory by ...", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "LOOK LATER", style: UIAlertActionStyle.default, handler: nil))
        alertController.addAction(UIAlertAction(title: "LOOK NOW", style: UIAlertActionStyle.default, handler:  {(action:UIAlertAction) in
            self.performSegue(withIdentifier: "showChat", sender: self)}))
        present(alertController, animated: true, completion: nil)
        print(msg)
    }
}


extension ElderlyMenuViewController: ServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            print("Connections: \(connectedDevices)")
        }
    }
    
    func communicatesMessage(manager: ServiceManager, message: String) {
        OperationQueue.main.addOperation {
            switch message {
            case "friendship request":
                self.showMessage(msg: "Mesaggio ricevuto")
                
            case "message by relatives":
                self.showAlert(msg: "Mesaggio ricevuto")
                
            case "memory by relatives":
                self.showMemory(msg: "Mesaggio ricevuto")
                
            default:
                NSLog("%@", "Unknown message value received: \(message)")
            }
        }
    }
}


extension ElderlyMenuViewController: UNUserNotificationCenterDelegate {
    
    // Notifica quando l'app è in foreground 
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge])
    }
    
    // Azione eseguita cliccando sulla notifica 
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier  {
            
        case "ACCEPT":
            print("ebnterertey")
        default:
            break
        }
        
        completionHandler()
    }
}
