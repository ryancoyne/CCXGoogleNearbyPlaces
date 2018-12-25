//
//  CCXGooglePlace.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

import CoreLocation

public struct GooglePlace : Codable {
    
    /// This is the id of the place.
    public var id : String?
    /// This returns the coordinate of the place nearby.
    public var geometry: GoogleGeometry?
    /// This returns the name of the place nearby.
    public var name: String?
    /// This returns the photos of the place nearby.
    public var photos: [GooglePhoto]?
    /// This returns the vicinity of the place nearby.
    public var vicinity: String?
    /// This returns a boolean indicating whether the place nearby is open.
    public var isOpen: GoogleOpeningHours
    /// This is an array of types for the place.
    public var types: [GooglePlaceType]?
    // This is the reference of the google place:
    public var reference : String?
    
    enum CodingKeys : String, CodingKey {
        case id = "place_id"
        case reference
        case geometry
        case name
        case photos
        case vicinity
        case isOpen = "opening_hours"
        case types
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(reference, forKey: .reference)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(vicinity, forKey: .vicinity)
        try container.encode(isOpen, forKey: .isOpen)
        try container.encode(photos, forKey: .photos)
        try container.encode(types, forKey: .types)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        geometry = try values.decode(GoogleGeometry.self, forKey: .geometry)
        name = try values.decode(String.self, forKey: .name)
        reference = try values.decode(String.self, forKey: .reference)
        photos = try values.decode([GooglePhoto].self, forKey: .photos)
        vicinity = try? values.decode(String.self, forKey: .vicinity)
        isOpen = try values.decode(GoogleOpeningHours.self, forKey: .isOpen)
        types = try values.decode([GooglePlaceType].self, forKey: .types)
    }
    
}
