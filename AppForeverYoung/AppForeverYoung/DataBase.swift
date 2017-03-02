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
    
    static func createUser(username: String, password: String, name: String, surname: String, telephone: String, type: String, imagePerson: UIImage) -> Bool {
        let semaphore = DispatchSemaphore(value: 0);
        var message = ""
        
        let URL_SAVE_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/createUser.php"
        var requestUrl = URLRequest(url: URL(string: URL_SAVE_TEAM)!)
        
        //setting the method to post
        requestUrl.httpMethod = "POST"
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "username="+username+"&password="+password+"&name="+name+"&surname="+surname+"&telephone="+telephone+"&type="+type+"&imagePerson="+""
       
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
    
    
    static func login(username: String, password: String) -> String {
        let semaphore = DispatchSemaphore(value: 0);
        let URL_LOAD_TEAM = "http://kingborn187.altervista.org/AppForeverYoung/UserService/api/getUsers.php"
        var choice = ""
        
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
                                choice = product["type"] as! String
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
        return choice
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
                        if globalUsername != person["username"] as! String {
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
        //executing the task
        task.resume()
        semaphore.wait()
        
        if message ==  "Memory added successfully" {
            return true
        } else {
            return false
        }
    }
    
    static func upload_image(url: String, image: UIImage, name: String) {
        
        let urlMast = NSURL(string: url)
        
        var request = URLRequest(url: urlMast! as URL)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let image_data = UIImagePNGRepresentation(image)
        let body = NSMutableData()
        let fname = name+".png"
        let mimetype = "image/png"
        
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
