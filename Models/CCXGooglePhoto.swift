//
//  CCXGooglePhoto.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

import Foundation

struct CCXGooglePhoto {
    
    var width: Int?
    var height: Int?
    var url: URL? {
        var buildURL = CCXGooglePhoto.host
        
        var queryParams : [String:Any] = ["key":CCXGoogleSDK.apiKey!]
        
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
    var maxwidth : Int?
    
    private static var host = URL(string: "https://maps.googleapis.com/maps/api/place/photo")!
    
    init(photoJSON: [String:Any]) {
        height = photoJSON["height"] as? Int
        width = photoJSON["width"] as? Int
        photoReference = photoJSON["photo_reference"] as? String
    }
    
}
