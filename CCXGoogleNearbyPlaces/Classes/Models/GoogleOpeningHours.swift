//
//  GoogleOpeningHours.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 12/24/18.
//

import Foundation

public struct GoogleOpeningHours : ExpressibleByBooleanLiteral, Codable {
    
    public var isOpen : Bool = false
    public typealias BooleanLiteralType = Bool
    public init(booleanLiteral value: BooleanLiteralType) {
        self.isOpen = value
    }
    
    static func ??(lhs : GoogleOpeningHours, rhs : Bool) -> Bool {
        return lhs.isOpen == rhs
    }
    static func ??(lhs : Bool, rhs : GoogleOpeningHours) -> Bool {
        return lhs == rhs.isOpen
    }
    
    enum CodingKeys : String, CodingKey {
        case isOpen = "open_now"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isOpen, forKey: .isOpen)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isOpen = try values.decode(Bool.self, forKey: .isOpen)
    }
}
