//
//  CCXGooglePlacesResponse.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

public struct GooglePlacesResponse : Codable {
    
    /// This returns the next page token.  Use this, and ONLY this for your next request, if needed.  It will return the next 20 results.
    public var nextPageToken : String?
    /// This returns an array of google places.
    public var places : [GooglePlace]?
    /// This returns a string of the status of the response.
    public var googleStatus : String?
    /// This returns an error for the URLResponse.
    public var errorMessage : String?
    /// This returns a status for the response.
    public var status : Int!
    /// This returns a boolean describing if you can use the nextPageToken for your next request, if paging is necessary.
    public var canLoadMore : Bool {
        return self.googleStatus == "OK" && self.nextPageToken.isNotNil
    }
    
    public var isSuccess : Bool {
        return (200 ... 299 ~= self.status)
    }
    
    enum CodingKeys : String, CodingKey {
        case places = "results"
        case googleStatus = "status"
        case nextPageToken = "next_page_token"
        case errorMessage = "error_message"
    }
    
    public init()  {  }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        places = try values.decode([GooglePlace].self, forKey: .places)
        googleStatus = try values.decode(String.self, forKey: .googleStatus)
        nextPageToken = try? values.decode(String.self, forKey: .nextPageToken)
        errorMessage = try? values.decode(String.self, forKey: .errorMessage)
    }
    
}
