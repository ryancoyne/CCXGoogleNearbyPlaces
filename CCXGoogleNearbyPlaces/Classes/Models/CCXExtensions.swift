//
//  CCXExtensions.swift
//  CCXGoogleNearbyPlaces
//
//  Created by Ryan Coyne on 11/11/17.
//

//MARK: - Optional Extension:
public extension Optional {
    /// This returns whether or not the optional is equal to nil.
    public var isNil : Bool {
        return self == nil
    }
    /// This returns whether or not the optional is not equal to nil.
    public var isNotNil : Bool {
        return self != nil
    }
    /// This returns the optional unwrapped into a boolean value.
    public var boolValue : Bool? {
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
    public var stringValue : String? {
        return self as? String
    }
    public var stringArray : [String]? {
        return self as? [String]
    }
    /// This returns the optionally wrapped object as a dictionary value.
    public var dicValue : [String:Any]! {
        return self as? [String:Any] ?? [:]
    }
    /// This returns the optionally wrapped object as an array of dictionaries...value.
    public var arrayDicValue : [[String:Any]]! {
        return self as? [[String:Any]] ?? [[:]]
    }
    /// This returns the optionally wrapped object as an integer value.
    public var intValue : Int? {
        if self.isNil { return nil }
        switch self {
        case is Int, is Int?:
            return self as? Int
        case is Double, is Double?:
            return Int(exactly: self as! Double)
        case is Float, is Float?:
            return Int(exactly: self as! Float)
        default:
            return nil
        }
    }
    /// This returns the optionally wrapped object as a double value.
    public var doubleValue : Double? {
        return self as? Double
    }
    /// This returns the optionally wrapped object as a float value.
    public var floatValue : Float? {
        return self as? Float
    }
    /// This returns the optionally wrapped object as a URL value.
    public var urlValue : URL? {
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
    /// This returns a boolean describing the success of the response.
    public var isSuccess : Bool {
        switch self.code {
        case 200...299:
            return true
        default:
            return false
        }
    }
    /// This returns a status enumeration, containing the success of the response, the code, and the description of the normal status repsonses.
    public var status : CCXHTTPResponseStatus {
        return CCXHTTPResponseStatus.statusFrom(code: self.code)
    }
    public var code : Int {
        return (self as? HTTPURLResponse)?.statusCode ?? -1
    }
    /// This returns the headers of the response
    public var headers : [AnyHashable:Any]? {
        return (self as? HTTPURLResponse)?.allHeaderFields 
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
    public var json : [String:Any]? {
        if let r = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] {
            return r
        } else {
            return nil
        }
    }
}

extension URL {
    /// Initialize a URL with some query parameters.  The scheme is defauled to https.
    public init(scheme: String?="https", host: String, path: String, queryParams: [String:Any]) {
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
    /// Add query parameters to your URL object using a dictionary.
    public mutating func addQueryParams(_ queryParams : [String:Any]) {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        
        // Start putting together the paths:
        for param in queryParams {
            // If the query items is nil, we need to initialize so we can actually add the items:
            if components?.queryItems.isNil == true {
                components?.queryItems = []
            }
            let queryItem = URLQueryItem(name: param.key, value: String(describing: param.value))
            components?.queryItems?.append(queryItem)
        
        }
        
        if let url = components?.url  {
            self = url
        }

    }
}
