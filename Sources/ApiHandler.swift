//
//  ApiHandler.swift
//  SwiftSample
//
//  Created by Eliel Kilembo on 2/17/24.
//

import Foundation

class ApiHandler{
    let userEndpoint = "https://blackvalleycomics.com/api/user"
    let latestEndpoint = "https://blackvalleycomics.com/api/latestissues"
    
    
    func sendUserData(profileUser:User){
        let apiUrl = URL(string: userEndpoint)!
        
        let postData: [String: Any] = [
            "email": profileUser.email,
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: postData) else {
            print("Error encoding JSON data")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid HTTP response")
                return
            }

            if let data = data {
                // Handle response data if needed
                print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }

        task.resume()
    }
    
    func getLatest(completion: @escaping ([[String:Any]]?) -> Void){
        let apiUrl = URL(string: latestEndpoint)!
        var request = URLRequest(url: apiUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid HTTP response")
                return
            }

            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let issues = dataDictionary["issues"] as! [[String:Any]]
//                print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }

        task.resume()
    }
}
