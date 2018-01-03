//
//  CommunicationManager.swift
//  ContactListApplication
//
//  Created by ketan on 02/01/18.
//  Copyright © 2018 MindIT. All rights reserved.
//

import UIKit

class CommunicationManager
{
    private init(){}
    
    static let sharedInstance : CommunicationManager = CommunicationManager()
    
    func execTask(pathParam:NSString, queryParam:NSString ,requestType:NSString, jsonDict:NSDictionary, taskCallback: @escaping (Bool,
        AnyObject?) -> ())
    {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        var urlComponents = URLComponents(string: "http://jsonplaceholder.typicode.com")!
        
        if pathParam != ""
        {
            urlComponents.path = pathParam as String
        }
        
        if queryParam != ""
        {
            urlComponents.query = queryParam as String
            
        }
        
        let url = urlComponents.url;
        
        var request = URLRequest(url:url!)
        
        print("\(url!)")
        
        
        if jsonDict.count != 0
        {
            //  let data:NSData! =  NSKeyedArchiver.archivedData(withRootObject: jsonDict) as NSData
            do
            {
                
                let jsonData = try JSONSerialization.data(withJSONObject: (jsonDict as! [String : Any]), options: .prettyPrinted)
                
                let jsonString : NSString =    NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String as String as NSString
                
                print("Json Request String :\(jsonString) ")
                
                
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                
                request.httpBody = jsonData as Data
                
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        
        
        
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requestType == "get"
        {
            request.httpMethod = "GET"
        }
        else
        {
            request.httpMethod = "POST"
        }
        
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            print("Response : ----- \(String(describing: response))")
            
            // print("Error :- \(error!)")
            
            if let data = data
            {
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode
                {
                    print(String(data: data, encoding: .utf8) ?? "not possible")
                    
                    if String(data: data, encoding: .utf8) != nil
                    {
                        taskCallback(true, json as AnyObject?)
                    }
                }
                else
                {
                    taskCallback(false, json as AnyObject?)
                }
            }
            else
            {
                taskCallback(false, nil as AnyObject?)
            }
        })
        task.resume()
    }

}
