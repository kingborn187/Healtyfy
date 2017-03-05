//
//  DataBase.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 17/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import Foundation
import UIKit

class DataBase {
    
    static func createUser(username: String, password: String, name: String, surname: String, telephone: String, type: String, imagePerson: UIImage, age: String) -> Bool {
        let semaphore = DispatchSemaphore(value: 0);
        var message = ""
        
        let URL_SAVE_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/createUser.php"
        var requestUrl = URLRequest(url: URL(string: URL_SAVE_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "POST"
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "username="+username+"&password="+password+"&name="+name+"&surname="+surname+"&telephone="+telephone+"&type="+type+"&imagePerson="+""+"&age="+age
       
        requestUrl.httpBody = postParameters.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("please enter a valid user")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            do {
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as?NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    //printing the response
                    print(msg)
                    message = msg
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        if message ==  "User added successfully" {
            upload_image(url: "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/addImage.php", image: imagePerson, name: telephone)
            return true
        } else {
            return false
        }
    }
    
    
    static func login(username: String, password: String) -> (telephone: String, type: String)? {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/getUsers.php"
        var result: (telephone: String, type: String)?
        
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        
        
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid name & member")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["users"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for product in dataArr {
                        //your code for accessing dd.
                        if username == product["username"] as! String {
                            if password == product["password"] as! String {
                                let type = product["type"] as! String
                                let telephone = product["telephone"] as! String
                                result = (telephone: telephone, type: type)
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        return result
    }
    
    static func findPersonWithPhone(telephone: String) -> (name: String, surname: String)? {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/getUsers.php"
        var person: (name: String, surname: String)?
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        
        
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid name & member")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["users"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for product in dataArr {
                        //your code for accessing dd.
                        if telephone == product["telephone"] as! String {
                            person = (name: product["name"] as! String, surname: product["surname"] as! String)
                        }
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return person
    }
    
    
    static func controlUsername(username: String) -> Bool {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/getUsers.php"
        var result = false
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        
        
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid name & member")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["users"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for product in dataArr {
                        //your code for accessing dd.
                        if username == product["username"] as! String {
                            result = true
                        }
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return result
    }
    
    
    static func controlTelephone(telephone: String) -> Bool {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/getUsers.php"
        var result = false
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        
        
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid name & member")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["users"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for product in dataArr {
                        //your code for accessing dd.
                        if telephone == product["telephone"] as! String {
                            result = true
                        }
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return result
    }
    
    
    static func createFriendship(usernameElderly: String, usernameRelative: String) -> Bool {
        let semaphore = DispatchSemaphore(value: 0);
        var message = ""
        
        let URL_SAVE_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/FriendService/api/createFriend.php"
        var requestUrl = URLRequest(url: URL(string: URL_SAVE_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "POST"
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "usernameElderly="+usernameElderly+"&usernameRelative="+usernameRelative
        
        requestUrl.httpBody = postParameters.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("please enter a valid friendship")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            do {
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as?NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    //printing the response
                    print(msg)
                    message = msg
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        if message ==  "Friendship added successfully" {
            return true
        } else {
            return false
        }
    }
    
    
    static func getPersonas() -> [String: (name: String, surname: String)] {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/getUsers.php"
        var personas: [String: (name: String, surname: String)] = [:]
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid name & member")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["users"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for person in dataArr {
                        //your code for accessing dd.
                        if (globalUsername != person["username"] as! String) && ("Elderly" == person["type"] as! String)  {
                            let telephone = person["telephone"] as! String
                            let name = person["name"] as! String
                            let surname = person["surname"] as! String
                            personas[telephone] = (name: name, surname: surname)
                        }
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return personas
    }
    
    
    static func getQuestions() -> [String] {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/QuestionService/api/getQuestions.php"
        var questions: [String] = Array()
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["questions"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for person in dataArr {
                        //your code for accessing dd.
                        questions.append(person["query"] as! String)
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return questions
    }
    
    
    static func createMemory(telephone: String, titleMemory: String, bodyMemory: String, dateMemory: String, timeMemory: String, imageMemory: UIImage) -> Bool {
        let semaphore = DispatchSemaphore(value: 0);
        var message = ""
        
        let URL_SAVE_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/MemoryService/api/createMemory.php"
        var requestUrl = URLRequest(url: URL(string: URL_SAVE_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "POST"
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "telephone="+telephone+"&titleMemory="+titleMemory+"&bodyMemory="+bodyMemory+"&dateMemory="+dateMemory+"&timeMemory="+timeMemory+"&imageMemory="+""
        
        requestUrl.httpBody = postParameters.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("please enter a valid user")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            do {
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as?NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    //printing the response
                    print(msg)
                    message = msg
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            semaphore.signal();
        })
        //
        //executing the task
        task.resume()
        semaphore.wait()
        
        if message ==  "Memory added successfully" {
            upload_image(url: "http://kingborn187.altervista.org/AppForeverYoung/MemoryService/api/addImage.php", image: imageMemory, name: telephone+titleMemory)

            return true
        } else {
            return false
        }
    }
    
    static func getMemory() -> [(titleMemory: String, bodyMemory: String, dateMemory: String, timeMemory: String, telephone: String)] {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/MemoryService/api/getMemory.php"
        var memory: [(titleMemory: String, bodyMemory: String, dateMemory: String, timeMemory: String, telephone: String)] = []
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["memory"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for person in dataArr {
                        //your code for accessing dd.
                        //let telephone = person["telephone"] as! String
                        let titleMemory = person["titleMemory"] as! String
                        let bodyMemory = person["bodyMemory"] as! String
                        let dateMemory = person["dateMemory"] as! String
                        let timeMemory = person["timeMemory"] as! String
                        let telephone = person["telephone"] as! String
                        
                        memory.append((titleMemory: titleMemory, bodyMemory: bodyMemory, dateMemory: dateMemory, timeMemory: timeMemory, telephone: telephone))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return memory
    }
    
    static func createChat(sender: String, consignee: String, message: String) {
        let semaphore = DispatchSemaphore(value: 0);
        
        let URL_SAVE_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/ChatService/api/createChat.php"
        var requestUrl = URLRequest(url: URL(string: URL_SAVE_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "POST"
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "sender="+sender+"&consignee="+consignee+"&message="+message
        requestUrl.httpBody = postParameters.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            do {
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as?NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    //printing the response
                    print(msg)
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
    }//
    
    static func getChat() -> [(sender: String, consignee: String, message: String)] {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/ChatService/api/getChats.php"
        var chat: [(sender: String, consignee: String, message: String)] = []
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["chats"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for person in dataArr {
                        //your code for accessing dd.
                        //let telephone = person["telephone"] as! String
                        let sender = person["sender"] as! String
                        let consignee = person["consignee"] as! String
                        let message = person["message"] as! String
                        
                        chat.append((sender: sender, consignee: consignee, message: message))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return chat
    }
    
    static func createNotification(sender: String, consignee: String, message: String) {
        let semaphore = DispatchSemaphore(value: 0);
        let date = Date()
        let calendar = Calendar.current
        let day = String(calendar.component(.day, from: date))
        let month = String(calendar.component(.month, from: date))
        let year = String(calendar.component(.year, from: date))
        let hour = String(calendar.component(.hour, from: date))
        let minute = String(calendar.component(.minute, from: date))
        let dateCurrent = day+"/"+month+"/"+year+" "+hour+":"+minute
        
        let URL_SAVE_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/NotificationService/api/createNotification.php"
        var requestUrl = URLRequest(url: URL(string: URL_SAVE_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "POST"
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "sender="+sender+"&consignee="+consignee+"&message="+message+"&date="+dateCurrent
        requestUrl.httpBody = postParameters.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            do {
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as?NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    //printing the response
                    print(msg)
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
    }

    
    static func getNotification() -> [(sender: String, consignee: String, message: String, date: String)] {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/NotificationService/api/getNotification.php"
        var notification: [(sender: String, consignee: String, message: String, date: String)] = []
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["notification"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for person in dataArr {
                        //your code for accessing dd.
                        //let telephone = person["telephone"] as! String
                        let sender = person["sender"] as! String
                        let consignee = person["consignee"] as! String
                        let message = person["message"] as! String
                        let date = person["date"] as! String
                        
                        notification.append((sender: sender, consignee: consignee, message: message, date: date))
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return notification
    }
    
    
    static func getAnswer(message: String) -> [String] {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/AnswerService/api/getAnswer.php"
        var answer: [String] = []
        
        //Set up the url request
        var requestUrl = URLRequest(url: URL(string: URL_LOAD_TEAM)!)
        //setting the method to post
        requestUrl.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: requestUrl, completionHandler: {
            (data, response, error) in
            
            //exiting if there is some error
            if error != nil {
                print("please enter a valid url")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data \(data)")
                return
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                
                //getting the JSON array teams from the response
                let data: NSArray = myJSON["answer"] as! NSArray
                if let dataArr = data as? [[String: Any]] {
                    for person in dataArr {
                        //your code for accessing dd.
                        //let telephone = person["telephone"] as! String
                        let query = person["query"] as! String
                        
                        if query == message {
                            let rsp = person["reply"] as! String
                            answer.append(rsp)
                        }
                    }
                }
            } catch {
                print(error)
            }
            semaphore.signal();
        })
        //executing the task
        task.resume()
        semaphore.wait()
        
        return answer
    }

    
    static func upload_image(url: String, image: UIImage, name: String) {
        
        let urlMast = NSURL(string: url)
        
        var request = URLRequest(url: urlMast! as URL)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let image_data = UIImageJPEGRepresentation(image, 0)
        let body = NSMutableData()
        let fname = name+".jpg"
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"photo\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("Incoming\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response , error
                == nil else {
                    print("error")
                    return
            }
            let dataString = String(data: data!, encoding:
                String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print(dataString!)
            
        }
        task.resume()
    }
    
    static func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }

}
