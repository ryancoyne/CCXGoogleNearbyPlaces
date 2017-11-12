//
//  CCXGooglePlace.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

import Foundation
import CoreLocation

public struct CCXGooglePlace {
    
    var location: CLLocationCoordinate2D?
    var name: String?
    var photos: [CCXGooglePhoto]?
    var vicinity: String?
    var isOpen: Bool?
    var types: [String]?
    
    init(placeJSON:[String: Any]?=nil) {
        // coordinates
        if let lat = placeJSON?["geometry"].dicValue["location"].dicValue["lat"].doubleValue, let lng = placeJSON?["geometry"].dicValue["location"].dicValue["lng"].doubleValue  {
                location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
    
        // name
        name = placeJSON?["name"].stringValue
        
        // opening hours
        if let open = placeJSON?["opening_hours"].dicValue["open_now"].boolValue {
            isOpen = open
        }
        
        // vicinity
        vicinity = placeJSON?["vicinity"].stringValue
        
        // types
        types = placeJSON?["types"].stringArray
        
        // photos
        photos = [CCXGooglePhoto]()
        if placeJSON?["photos"].arrayDicValue.isEmpty == false {
            // Initialize the photos array:
            photos = []
            for p in placeJSON!["photos"].arrayDicValue {
                photos?.append(CCXGooglePhoto(photoJSON: p))
            }
        }
    }
}
