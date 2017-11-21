# CCXGoogleNearbyPlaces

[![CI Status](http://img.shields.io/travis/ryancoyne_/CCXGoogleNearbyPlaces.svg?style=flat)](https://travis-ci.org/ryancoyne_/CCXGoogleNearbyPlaces)
[![Version](https://img.shields.io/cocoapods/v/CCXGoogleNearbyPlaces.svg?style=flat)](http://cocoapods.org/pods/CCXGoogleNearbyPlaces)
[![License](https://img.shields.io/cocoapods/l/CCXGoogleNearbyPlaces.svg?style=flat)](http://cocoapods.org/pods/CCXGoogleNearbyPlaces)
[![Platform](https://img.shields.io/cocoapods/p/CCXGoogleNearbyPlaces.svg?style=flat)](http://cocoapods.org/pods/CCXGoogleNearbyPlaces)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CCXGoogleNearbyPlaces is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CCXGoogleNearbyPlaces'
```

## Integration

### You need an API key
Once you have downloaded and successfully built the module, go to your AppDelegate file and import the CCXGoogleNearlyPlaces module.

You will then need to go and make sure you have an API key to use the cocoapod.  Please reference the following to obtain your API key:
- [Get an API Key](https://developers.google.com/places/web-service/get-api-key)

### Configuring your API key
Once you have obtained a valid API key from the link above, you will set your api key as the following:
```
CCXGoogleSDK.places.apiKey = "Your API Key"
```

### Usage Details
There are a few ways you can fetch results with the CCXGoogleNearbyPlaces pod.  You may use a text parameter with a distance, from a location.  The API returns 20 results.  In the response object we will indicate whether or not you can load more objects.   You may load the next page by only passing in the next page token on your next request.

### Usage Examples

Get all the nearby places with a radius & a location coordinate, and a text parameter:
```
let coord = CLLocationCoordinate2D()
// Radius is in meters.
CCXGoogleSDK.places.get(withText: "restaurants", withRadius: 300.4, coordinate: coord) { response in
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

Get all the nearby places with only a radius & a location coordinate:
```
let coord = CLLocationCoordinate2D()
// Radius is in meters.
CCXGoogleSDK.places.get(withRadius: 300.4, coordinate: coord) { response in
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

Get all the nearby places with your next page token:
```
CCXGoogleSDK.places.get(pageToken: "nextPageToken") { (response) in

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
Documentation links:
- [Searching Documentation](https://developers.google.com/places/web-service/search)
- [Photo Documentation](https://developers.google.com/places/web-service/photos)

## Author

ryancoyne_, ryan@clearcodex.com

## License

CCXGoogleNearbyPlaces is available under the MIT license. See the LICENSE file for more info.
