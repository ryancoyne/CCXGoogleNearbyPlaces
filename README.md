# GoogleNearbyPlaces

[![CI Status](http://img.shields.io/travis/ryancoyne/CCXGoogleNearbyPlaces.svg?style=flat)](https://travis-ci.org/ryancoyne/CCXGoogleNearbyPlaces)
[![Version](https://img.shields.io/cocoapods/v/CCXGoogleNearbyPlaces.svg?style=flat)](http://cocoapods.org/pods/CCXGoogleNearbyPlaces)
[![License](https://img.shields.io/cocoapods/l/CCXGoogleNearbyPlaces.svg?style=flat)](http://cocoapods.org/pods/CCXGoogleNearbyPlaces)
[![Platform](https://img.shields.io/cocoapods/p/CCXGoogleNearbyPlaces.svg?style=flat)](http://cocoapods.org/pods/CCXGoogleNearbyPlaces)

## Why use GoogleNearbyPlaces?
- I made this cocoapod for the use of Google Maps & integrating a way to search nearby places without the generic search controller that they provide.  This give you the flexibility of making your own custom search UI.
- GoogleNearbyPlaces gives you ALL the options using the API.  It gives you the photo URL's for the places found as well as paging results, searching by a set type/category or custom category & search by text credientials.
- GoogleNearbyPlaces does NOT use another other third party networking tools to complete the API calls.  

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

From there, you may set a breakpoint in the AppDelegate where we call to the Nearby Places API and give a response & see if this is a cocoapod that could be of use for you.

## Installation

GoogleNearbyPlaces is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GoogleNearbyPlaces'
```

## Integration

### You need an API key
Once you have downloaded and successfully built the module, go to your AppDelegate file and import the GoogleNearlyPlaces module.

You will then need to go and make sure you have an API key to use the cocoapod.  Please reference the following to obtain your API key:
- [Get an API Key](https://developers.google.com/places/web-service/get-api-key)

### Configuring your API key
Once you have obtained a valid API key from the link above, you will set your api key as the following:
```
GoogleNearbyPlacesSDK.places.apiKey = "Your API Key"
```

### Usage Details
There are a few ways you can fetch results with the GoogleNearbyPlaces pod.  You may use a text parameter with a distance, from a location.  The API returns 20 results.  In the response object we will indicate whether or not you can load more objects.   You may load the next page by only passing in the next page token on your next request.

### Usage Examples

Get all the nearby places with a radius & a location coordinate, and a text parameter:
```
let coord = CLLocationCoordinate2D()
// Radius is in meters.
GoogleNearbyPlacesSDK.places.get(withText: "restaurants", withRadius: 300.4, coordinate: coord) { response in
    if response.status.isSuccess {
        if response.places.isNotNil {
            if response.canLoadMore {
            // You should only use the pageToken in the get function on your next request.
                self.queueForNextLoad = true
            }
            // Deal with the places:
            print(response.places!)
        }
    } else if response.error.isNotNil {
            //
        print(response.error!)
    }
}
```

Get all the nearby places with only a radius & a location coordinate:
```
let coord = CLLocationCoordinate2D()
// Radius is in meters.
GoogleNearbyPlacesSDK.places.get(withRadius: 300.4, coordinate: coord) { response in
    if response.status.isSuccess {
        if response.places.isNotNil {
            if response.canLoadMore {
                // You should only use the pageToken in the get function on your next request.
                self.queueForNextLoad = true
            }
            // Deal with the places:
            print(response.places!)
        }
    } else if response.error.isNotNil {
        //
        print(response.error!)
    }
}
```

Get all the nearby places with your next page token:
```
GoogleNearbyPlacesSDK.places.get(pageToken: "nextPageToken") { (response) in

    if response.status.isSuccess {
        if response.places.isNotNil {
            if response.canLoadMore {
            // You should only use the pageToken in the get function on your next request.
                self.queueForNextLoad = true
            }
            // Deal with the places:
            print(response.places!)
        }
    } else if response.error.isNotNil {
        //
        print(response.error!)
    }

}
```

Get places around you with a specific type or category:
```
GoogleNearbyPlacesSDK.places.get(withRadius: 200.4, coordinate: coord, category: .hairCare) { (response) in
    if response.status.isSuccess {
        if response.places.isNotNil {
            if response.canLoadMore {
            // You should only use the pageToken in the get function on your next request.

            }
            // Deal with the places:
            print(response.places!)
        }
    } else if response.error.isNotNil {
        //
        print(response.error!)
    }
}
```

## More
Google Documentation links:
- [Searching Documentation](https://developers.google.com/places/web-service/search)
- [Photo Documentation](https://developers.google.com/places/web-service/photos)

## Author

ryancoyne, ryan@clearcodex.com

## License

GoogleNearbyPlaces is available under the MIT license. See the LICENSE file for more info.
