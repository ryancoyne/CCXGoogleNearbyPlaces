import UIKit
import XCTest
import CCXGoogleNearbyPlaces

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDecodingASuccessfulRespone() {
        
        var theResponse = [String:Any]()
        theResponse["status"] = "OK"
        var results = [[String:Any]]()
        for _ in 0...5 {
            var place = [String:Any]()
            place["id"] = "21a0b251c9b8392186142c798263e289fe45b4aa"
            place["name"] = "Some Name"
            place["vicinity"] = "The vicinity."
            var geometry  = [String:Any]()
            geometry["location"] = ["lat":38.9922, "lng":-77.02022]
            var openingHours = [String:Any]()
            openingHours["open_now"] = true
            
            place["types"] = ["restaurant", "food", "establishment"]
            place["opening_hours"] = openingHours
            place["geometry"] = geometry
            
            results.append(place)
        }
        theResponse["results"] = results
        
        // Now lets bring this [String:Any] object to data:
        if let theData = try? JSONSerialization.data(withJSONObject: theResponse) {
            do {
                var theResponse = try JSONDecoder().decode(GooglePlacesResponse.self, from: theData)
                theResponse.status = 200
                print(theResponse)
            } catch {
                print(error)
            }
        }
        
    }
    
}
