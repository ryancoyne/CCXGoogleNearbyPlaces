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
        var url = CCXGooglePhoto.host
       
        if let apiKey = CCXGooglePlaces.apiKey {
            if maxwidth != nil {
                url.appendPathComponent("?maxwidth=\(self.maxwidth!)")
            }
            if photoReference != nil {
                url.appendPathComponent("&photoreference=\(self.photoReference!)")
            }
            url.appendPathComponent("&key=\(apiKey)")
            
            return url
        } else {
            return nil
        }

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
