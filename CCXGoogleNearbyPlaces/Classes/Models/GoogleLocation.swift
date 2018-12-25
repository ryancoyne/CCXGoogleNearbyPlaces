//
//  GoogleLocation.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 12/24/18.
//

import Foundation

public struct GoogleLocation : Codable {
    var latitude : Double
    var longitude : Double
    
    enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}
