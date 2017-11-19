//
//  CCXGooglePlace.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

import CoreLocation

public struct CCXGooglePlace {
    
    /// This returns the coordinate of the place nearby.
    var location: CLLocationCoordinate2D?
    /// This returns the name of the place nearby.
    var name: String?
    /// This returns the photos of the place nearby.
    var photos: [CCXGooglePhoto]?
    /// This returns the vicinity of the place nearby.
    var vicinity: String?
    /// This returns a boolean indicating whether the place nearby is open.
    var isOpen: Bool?
    /// This is an array of types for the place.
    var types: [CCXGooglePlaceType]?
    
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
        if let array = placeJSON?["types"].stringArray {
            if types.isNil {
                types = []
                for type in array {
                    types?.append(CCXGooglePlaceType.from(type))
                }
            }
        }
    
        // photos
        if let jsonPhotos = placeJSON?["photos"].arrayDicValue {
            // Initialize the photos array:
            photos = []
            for p in jsonPhotos {
                photos?.append(CCXGooglePhoto(photoJSON: p))
            }
        }
    }
}
