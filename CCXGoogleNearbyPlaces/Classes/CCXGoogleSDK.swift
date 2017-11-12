
import Foundation
import CoreLocation

public struct CCXGoogleSDK {
    
    private init () {  }
    /// This is the base URL for the Google Places API
    private static let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json")!
    /// All the categories that you can use that are pre-created.
    static public var categories : [CCXGooglePlacesCategory] = [
        .ATM, .bakery, .doctor, .gym, .hairCare, .pharmacy, .restaurant, .store, .spa, .taxiStand
    ]
    
    /// The CCX Google Places SDK structure.
    public struct places {
        /// This is your API key.  You need to set it to get places around you.
        static public var apiKey : String? = nil
        
        /**
         Get the places within your area.  If you get a response back that canLoadMore as true, only pass in the pageToken to get more results.
         
         ---
         
         # Notes #
         1.  After the initial request, if the response gives back the canLoadMore boolean, all you need to do is take the nextPageToken and set that as the parameters for the request, without the radius & coordinate.
         2.  This is an **asynchronous** request.
         3.  You may check the response status or check the success of the request.
         
         ---
         ## Usage Example: ##
         `````
         CCXGoogleSDK.places.get(withRadius: 300, coordinate: coord) { response in
         if response.status.isSuccess {
         if response.places.isNotNil {
         if response.canLoadMore {
         // You should only use the pageToken in the get function on your next request.
         }
         // Deal with the places:
         print(response.places!)
         }
         } else if response.error.isNotNil {
         print(response.error!)
         }
         }
         
         `````
         ---
         - parameter withRadius:  This specifies the radius of the results in which are returned, in meters.
         - parameter coordinate:  This is the users OR coordinate point of which you would like the results returned.
         - parameter category:  This is the category of which you would like the results returned.
         - parameter pageToken:  This page token is used to page the results.  This is given to you in the CCXGooglePlacesResponse.
         - parameter response:  This is the response.  This contains the places, the page token, a boolean to indicate if you need to page, and more!
         
         */
        static public func get(withRadius: Int?=nil, coordinate: CLLocationCoordinate2D?=nil, category: CCXGooglePlaceType?=nil, pageToken : String?=nil, _ completion: @escaping (_ response : CCXGooglePlacesResponse) -> Void) {
            
            guard let theAPIKey = places.apiKey, !theAPIKey.isEmpty, !theAPIKey.replacingOccurrences(of: " ", with: "").isEmpty else {
                // Return a fatal error.  We need the api key to generate any response:
                fatalError("[CCXGoogleSDK] ERROR:  You need to set your Google Places API key.  Please go to \"https://developers.google.com/places/web-service/get-api-key\"")
            }
            
            var placesURL =  url
            var params : [String:Any] = ["key":theAPIKey]
            if pageToken.isNil {
                if coordinate.isNotNil {
                    params["location"] = "\(coordinate!.latitude),\(coordinate!.longitude)"
                }
                if category.isNotNil {
                    params["type"] = category!.description
                }
                if withRadius.isNotNil {
                    params["radius"] = withRadius!
                }
                
            } else {
                params["pagetoken"] = pageToken!
            }
            
            placesURL.addQueryParams(params)
            
            let request = URLRequest(url: placesURL)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                var ccxResponse = CCXGooglePlacesResponse(json: data?.json, response: response)
                ccxResponse.error = error
                DispatchQueue.main.async {
                    completion(ccxResponse)
                }
            }.resume()
        }
    }
}
