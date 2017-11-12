
import Foundation
import CoreLocation

public struct CCXGoogleSDK {
    
    static public var apiKey : String? = nil
    private init () {  }
    private static let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json")!
    static public var categories : [CCXGooglePlacesCategory] = [
        .ATM, .bakery, .doctor, .gym, .hairCare, .pharmacy, .restaurant, .store, .spa, .taxiStand
    ]
    
    /// Get the places within your area.  If you get a response back that canLoadMore as true, only pass in the pageToken to get more results.
    static public func getPlaces(withRadius: Int?=nil, coordinate: CLLocationCoordinate2D?=nil, category: CCXGooglePlacesCategory?=nil, pageToken : String?=nil, _ completion: @escaping (_ response : CCXGooglePlacesResponse) -> Void) {
        
        guard let theAPIKey = apiKey else {
            // Return a fatal error.  We need the api key to generate any response:
            fatalError("[CCXGoogleSDK] ERROR:  You need to set your Google Places API key.  Please go to \"https://developers.google.com/places/web-service/get-api-key\"")
        }
        
        var placesURL = url
        var params = ["key":theAPIKey]
        if pageToken.isNil {
            if coordinate.isNotNil {
                params["location"] = "\(coordinate!.latitude),\(coordinate!.longitude)"
            }
            if category.isNotNil {
                params["type"] = category!.description
            }
            
        } else {
            params["pagetoken"] = pageToken!
        }
        
        placesURL.addQueryParams(params)
        
        var request = URLRequest(url: placesURL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let ccxResponse = CCXGooglePlacesResponse(json: data?.json)
            ccxResponse.error = error
            ccxResponse.status = CCXHTTPResponseStatus.statusFrom(code: response.status.code)
        }
    }
}
