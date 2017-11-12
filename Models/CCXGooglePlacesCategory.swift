//
//  CCXGooglePlacesCategory.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

public enum CCXGooglePlacesCategory : CustomStringConvertible {
    
    case custom(value : String) 
    case bakery, doctor, taxiStand, hairCare, restaurant, pharmacy, ATM, gym, store, spa
    
    public var description: String {
        switch self {
        case .ATM:
            return "atm"
        case .bakery:
            return "bakery"
        case .doctor:
            return "doctor"
        case .gym:
            return "gym"
        case .hairCare:
            return "hair_care"
        case .pharmacy:
            return "pharmacy"
        case .restaurant:
            return "restaurant"
        case .spa:
            return "spa"
        case .store:
            return "store"
        case .taxiStand:
            return "taxi_stand"
        case .custom(value: let val):
            return val
        }
    }
}
