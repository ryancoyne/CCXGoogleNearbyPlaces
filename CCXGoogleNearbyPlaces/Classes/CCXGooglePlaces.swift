
import Foundation

public struct CCXGooglePlaces {
    static var apiKey : String? = nil
    
    private let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json")!
    
    static var categories : [CCXGooglePlacesCategory] = [
        .ATM, .bakery, .doctor, .gym, .hairCare, .pharmacy, .restaurant, .store, .spa, .taxiStand
    ]
}
