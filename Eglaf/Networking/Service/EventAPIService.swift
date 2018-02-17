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
    func userCheckedAt(eventId: String, ticketId: String) -> SignalProducer<CheckInResponse?, RequestError>
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
    
    func userCheckedAt(eventId: String, ticketId: String) -> SignalProducer<CheckInResponse?, RequestError> {
        return self.request("\(eventId)/checkin/\(ticketId)", method: .post)
            .mapError { .network($0) }
            .map{ (data: Any?) in
                var checkInResponse: CheckInResponse?
                
                if let response = data as? [String : Any] {
                    checkInResponse = CheckInResponse(dictionary: response)
                }
                
                return checkInResponse
        }
    }
}

