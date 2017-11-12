//
//  CCXGooglePlacesResponse.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

import Foundation

public struct CCXGooglePlacesResponse {
    
    public var nextPageToken : String? = nil
    public var places : [CCXGooglePlace]?
    private var googleStatus : String? = nil
    public var error : Error?
    public var status : CCXHTTPResponseStatus!
    public var canLoadMore : Bool {
        return self.googleStatus == "OK" && self.nextPageToken.isNotNil
    }
    
    init(json: [String:Any]?=nil) {
        
        self.googleStatus            = json?["status"].stringValue
        self.nextPageToken        = json?["next_page_token"].stringValue
        
        // Append the places:
        if json?["results"].arrayDicValue.isEmpty == false {
            self.places = []
            for result in json!["results"].arrayDicValue {
                self.places?.append(CCXGooglePlace(placeJSON: result))
            }
        }
    }
    
}
