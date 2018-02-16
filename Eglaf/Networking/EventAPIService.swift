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
    func getTickets() -> SignalProducer<[Ticket],RequestError>
}


/**
 Concrete class for creating api calls to our server
 */
class EventAPIService : APIService, EventAPIServicing {
    
    override func resourceURL(_ path: String) -> URL {
        let URL = Foundation.URL(string: "https://svc.hackathon.myia.com/swagger/")!
        let relativeURL = Foundation.URL(string: path, relativeTo: URL)!
        return relativeURL
    }
    
    internal func getTickets() -> SignalProducer<[Ticket], RequestError> {
        return self.request("")
            .mapError { .network($0) }
            .map{ (data: Any?) in
                var recipes : [Ticket] = []
                
                if let array = data as? [[String : Any]] {
                    array.forEach(
                        { (dictionary) in
                            let recipe = Ticket(dictionary: dictionary)
                            //recipe.setValuesForKeys(dictionary)
                            recipes.append(recipe)
                        }
                    )
                }
                
                return recipes
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

