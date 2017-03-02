
import UIKit
import UserNotifications

class ElderlyMenuViewController: UIViewController {
    
    @IBOutlet weak var ImmagineMemories: UIButton!
    let serviceManager = ServiceManager()
    
    @IBOutlet weak var ImmagineChat: UIButton!
    @IBOutlet weak var ImmagineNotifications: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImmagineMemories.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        ImmagineMemories.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        ImmagineMemories.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        ImmagineMemories.layer.shadowOpacity = 0.9
        
        ImmagineChat.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        ImmagineChat.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        ImmagineChat.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        ImmagineChat.layer.shadowOpacity = 0.9
        
        ImmagineNotifications.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        ImmagineNotifications.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        ImmagineNotifications.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        ImmagineNotifications.layer.shadowOpacity = 0.9
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
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
