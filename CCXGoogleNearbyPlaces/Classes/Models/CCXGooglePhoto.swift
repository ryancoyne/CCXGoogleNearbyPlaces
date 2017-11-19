//
//  CCXGooglePhoto.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

public struct CCXGooglePhoto {
    
    public var width: Int?
    public var height: Int?
    public var url: URL? {
        var buildURL = CCXGooglePhoto.host
        
        var queryParams : [String:Any] = ["key":CCXGoogleSDK.places.apiKey!]
        
        if maxwidth != nil {
            queryParams["maxwidth"] = self.maxwidth!
        }
        if photoReference != nil {
            queryParams["photoreference"] = self.photoReference!
        }
        buildURL.addQueryParams(queryParams)
        return buildURL
    }
    private var photoReference : String?
    public var maxwidth : Int?
    
    private static var host = URL(string: "https://maps.googleapis.com/maps/api/place/photo")!
    
    init(photoJSON: [String:Any]) {
        self.height = photoJSON["height"] as? Int
        self.width = photoJSON["width"] as? Int
        self.photoReference = photoJSON["photo_reference"] as? String
    }
    
}
