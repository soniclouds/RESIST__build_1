//
//  EventModel.swift
//  RES!ST__v1
//
//  Created by soniclouds on 3/16/17.
//  Copyright © 2017 soniclouds. All rights reserved.
//

import Foundation

class EventModel {
    static func getAllEvents(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://localhost:8000/events")
        let session = URLSession.shared
        let event = session.dataTask(with: url!, completionHandler: completionHandler)
        
        event.resume()
        
    }
    
    static func addEvent(address: String, city: String, country: String, date: Date, details: String, link: String, name: String, neighborhood: String, state: String, zip: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://localhost:8000/events") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "POST"
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = "address=\(address), city=\(city), country=\(country), date=\(date), details=\(details), link=\(link), name=\(name), neighborhood=\(neighborhood), state=\(state), zip=\(zip)"
            print ("bodyData: ", bodyData)
            
            //            "objective=\(objective)"
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            // Create the session
            let session = URLSession.shared
            let event = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            event.resume()
        }
    }
}
