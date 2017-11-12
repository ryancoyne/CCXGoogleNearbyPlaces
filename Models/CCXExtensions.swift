//
//  CCXExtensions.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

import Foundation

//MARK: - Optional Extension:
extension Optional {
    /// This returns whether or not the optional is equal to nil.
    var isNil : Bool {
        return self == nil
    }
    /// This returns whether or not the optional is not equal to nil.
    var isNotNil : Bool {
        return self != nil
    }
    /// This returns the optional unwrapped into a boolean value.
    var boolValue : Bool? {
        if self.isNil {
            return nil
        }
        switch self {
        case is String, is String?:
            return Bool(self as! String)
        case is Int, is Int?:
            return Bool(self as! Int)
        default:
            return nil
        }
    }
    /// This returns the optionally wrapped object as a string value.
    var stringValue : String? {
        return self as? String
    }
    var stringArray : [String]? {
        return self as? [String]
    }
    /// This returns the optionally wrapped object as a dictionary value.
    var dicValue : [String:Any]! {
        return self as? [String:Any] ?? [:]
    }
    /// This returns the optionally wrapped object as an array of dictionaries...value.
    var arrayDicValue : [[String:Any]]! {
        return self as? [[String:Any]] ?? [[:]]
    }
    /// This returns the optionally wrapped object as an integer value.
    var intValue : Int? {
        return self as? Int
    }
    /// This returns the optionally wrapped object as a double value.
    var doubleValue : Double? {
        return self as? Double
    }
    /// This returns the optionally wrapped object as a float value.
    var floatValue : Float? {
        return self as? Float
    }
    /// This returns the optionally wrapped object as a URL value.
    var urlValue : URL? {
        if self.isNil {
            return nil
        }
        switch self {
        case is String, is Optional<String>:
            return URL(string: self.stringValue!)
        case is URL, is URL?:
            return self as? URL
        default:
            return nil
        }
    }
}

extension Optional where Wrapped == URLResponse {
    var isSuccess : Bool {
        switch self.code {
        case 200...299:
            return true
        default:
            return false
        }
    }
    var status : CCXHTTPResponseStatus {
        return CCXHTTPResponseStatus.statusFrom(code: self.code)
    }
    private var code : Int {
        return (self as? HTTPURLResponse)?.statusCode ?? -1
    }
    var headers : [AnyHashable:Any] {
        return (self as! HTTPURLResponse).allHeaderFields
    }
}
//MARK: - Boolean Extension:
extension Bool {
    init(_ integerValue : Int) {
        if integerValue == 0 {
            self.init(false)
        } else {
            self.init(true)
        }
    }
}

//MARK: - Data Extension:
extension Data {
    var json : [String:Any]? {
        if let r = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] {
            return r
        } else {
            return nil
        }
    }
}

extension URL {
    init(scheme: String?="https", host: String, path: String, queryParams: [String:Any]) {
        var comps = URLComponents()
        comps.scheme = scheme!
        comps.host = host
        comps.path = path
        // Start putting together the paths:
        var queryItems : [URLQueryItem] = []
        for param in queryParams {
            queryItems.append(URLQueryItem(name: param.key, value: String(describing: param.value)))
        }
        comps.queryItems = queryItems
        self = comps.url!
    }
    mutating func addQueryParams(_ queryParams : [String:Any]) {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        // Start putting together the paths:
        
        var queryItems : [URLQueryItem] = []
        for param in queryParams {
            queryItems.append(URLQueryItem(name: param.key, value: String(describing: param.value)))
        }
        components?.queryItems?.append(contentsOf: queryItems)
        if let url = components?.url {
            self = url
        }
    }
}
