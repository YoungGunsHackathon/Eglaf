//
//  EventAPIService.swift
//  Eglaf
//
//  Created by Adam Zvada on 16.02.18.
//  Copyright © 2018 Adam Zvada. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol EventAPIServicing {
    func getTickets(eventId: String) -> SignalProducer<Tickets?, RequestError>
    //func getTicketArray(eventId: String) -> SignalProducer<[Ticket], RequestError>
}


/**
 Concrete class for creating api calls to our server
 */
class EventAPIService : APIService, EventAPIServicing {
    
    override func resourceURL(_ path: String) -> URL {
        let URL = Foundation.URL(string: "https://svc.hackathon.getmyia.com/hackathon/tickets/")!
        let relativeURL = Foundation.URL(string: path, relativeTo: URL)!
        return relativeURL
    }
    
//    func getTicketArray(eventId: String) -> SignalProducer<Tickets?, RequestError> {
//
//
//
//    }
    
    func getTickets(eventId: String) -> SignalProducer<Tickets?, RequestError> {
        return self.request("\(eventId)")
            .mapError { .network($0) }
            .map{ (data: Any?) in
                var tickets: Tickets?
                
                if let value = data as? [String : Any] {
                    tickets = Tickets(dictionary: value)
                }

                return tickets
        }
    }
    
//    internal func getRecipeDetail(recipeID: String) -> SignalProducer<Any?, RequestError> {
//        return self.request("recipes/\(recipeID)").mapError { .network($0) }
//    }
//
    //    internal func createNewRecipe(recipe: Recipe) -> SignalProducer<Any?, RequestError> {
    //
    //        var param : [String : Any] = [""]
    //
    //        return self.request("recipes", method: .post, parameters: [String: Any]? = nil, encoding: URLEncoding.default, headers: [String: String] = [:], authHandler: nil)
    //    }
    
    
    
}

