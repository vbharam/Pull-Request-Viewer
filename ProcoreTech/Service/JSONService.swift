//
//  JSONService.swift
//  ProcoreTech
//
//  Created by Vishal Bharam on 11/11/18.
//  Copyright © 2018 Vishal Bharam. All rights reserved.
//

import Foundation

// JSONService : Class to get JSON data from server
public class JSONService {
    public init() {}

    // GetData function to get JSON data
    func getData(url:String, completionHandler: @escaping (([[String: AnyObject]]?) -> Void)) -> Void {
        let url: NSURL = NSURL(string: url)!
        let task = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error -> Void in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    return completionHandler(json)
                } catch let error as NSError {
                    print("Error: \(error.localizedDescription)")
                } catch {
                    print("Something went wrong!")
                }
            }
            return completionHandler(nil)
        }) // End of dataTaskWithURL
        task.resume()
    }// End of getData function


    // Post function to send data
    func sendData(url:String, withData params: [String: AnyObject], completionHandler: @escaping (([String: AnyObject]?) -> Void)) -> Void {
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: [])
            request.httpBody = data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error: \(error!.localizedDescription)")
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                        return completionHandler(json)
                    } catch let error as NSError {
                        print("Error: \(error.localizedDescription)")
                    } catch {
                        print("Something went wrong!")
                    }
                }
                return completionHandler(nil)
            }
        } // End of dataTaskWithURLRequest
        task.resume()

    }// End of sendData function

}// End of JSONService

