//
//  APIManager.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Linah abdulaziz on 22/05/1443 AH.
//

import Foundation
import Foundation

class ApiManager{
    
    static func getApiResponse(urlPath: String, completionHandler: @escaping (Data?, Error?) -> Void ) {
            let urlSession = URLSession.shared
            guard let url = URL.init(string: urlPath) else { return }
            
            print("1. before api call")
            let task = urlSession.dataTask(with: url) { data, response, error in
                print("2. during an api call")
                if error != nil {
                    print("error: \(String(describing: error?.localizedDescription))")
                    completionHandler(nil, error)
                } else {
                    completionHandler(data, nil)
                }
            }
            
            task.resume()
            
            print("3. after api call")
        }
    
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string:"https://fierce-anchorage-83610.herokuapp.com/tasks") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
        
    }
    
    static func deleteTasks(index:Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string:"https://fierce-anchorage-83610.herokuapp.com/tasks/\(index)/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "DELETE"
           
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
        
        
    }
    static func updateTask(index:Int,objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
             // Create the url to request
                    if let urlToReq = URL(string: "https://fierce-anchorage-83610.herokuapp.com/tasks/\(index)/") {
                        // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                        var request = URLRequest(url: urlToReq)
                        // Set the method to PUT
                        request.httpMethod = "PUT"
                        // Create some bodyData and attach it to the HTTPBody
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.setValue("application/json", forHTTPHeaderField: "Accept")
                        // Create some bodyData and attach it to the HTTPBody
                        let bodyData = "{\"objective\":\"\(objective)\"}"
                        request.httpBody = bodyData.data(using: .utf8)
                        // Create the session
                        let session = URLSession.shared
                        let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                        task.resume()
                    }
        }


        
}
