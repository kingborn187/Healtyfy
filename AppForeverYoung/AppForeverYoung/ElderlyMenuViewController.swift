
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
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
