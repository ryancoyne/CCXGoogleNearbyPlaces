//
//  CCXGooglePhoto.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

public struct GooglePhoto : Codable {
    
    public var width: Int?
    public var height: Int?
    public var htmlAttributions : [String]
    public var url: URL? {
        var buildURL = GooglePhoto.host
        
        var queryParams : [String:Any] = ["key":GoogleNearbyPlacesSDK.places.apiKey!]
        
        if maxwidth != nil {
            queryParams["maxwidth"] = self.maxwidth!
        }
        if photoReference != nil {
            queryParams["photoreference"] = self.photoReference!
        }
        buildURL.addQueryParams(queryParams)
        return buildURL
    }
    public var photoReference : String?
    public var maxwidth : Int?
    
    private static var host = URL(string: "https://maps.googleapis.com/maps/api/place/photo")!
    
    enum CodingKeys : String, CodingKey {
        case width
        case height
        case photoReference = "photo_reference"
        case maxwidth
        case htmlAttributions = "html_attributions"
    }
    
}
