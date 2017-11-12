//
//  CCXGooglePlacesResponse.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

import Foundation

public struct CCXGooglePlacesResponse {
    
    /// This returns the next page token.  Use this, and ONLY this for your next request, if needed.  It will return the next 20 results.
    public var nextPageToken : String? = nil
    /// This returns an array of google places.
    public var places : [CCXGooglePlace]?
    /// This returns a string of the status of the response.
    private var googleStatus : String? = nil
    /// This returns an error for the URLResponse.
    public var error : Error?
    /// This returns a status for the response.
    public var status : CCXHTTPResponseStatus!
    /// This returns a boolean describing if you can use the nextPageToken for your next request, if paging is necessary.
    public var canLoadMore : Bool {
        return self.googleStatus == "OK" && self.nextPageToken.isNotNil
    }
    
    internal init(json: [String:Any]?=nil, response: URLResponse?=nil) {
        
        self.googleStatus            = json?["status"].stringValue
        self.nextPageToken        = json?["next_page_token"].stringValue
        print(response.code)
        self.status = CCXHTTPResponseStatus.statusFrom(code: response.code)
        if let errorMessage = json?["error_message"].stringValue, let response = response {
            self.error = NSError(domain: response.url?.host ?? "Unknown domain", code: self.status.code, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        }
        // Append the places:
        if json?["results"].arrayDicValue.isEmpty == false {
            self.places = []
            for result in json!["results"].arrayDicValue {
                self.places?.append(CCXGooglePlace(placeJSON: result))
            }
        }
    }
}
