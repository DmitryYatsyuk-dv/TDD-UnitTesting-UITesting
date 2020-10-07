//
//  LocationTests.swift
//  ToDoListWithCoverageTests
//
//  Created by Lucky on 04.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoListWithCoverage

class LocationTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testInitsSetsName() {
        let location = Location(name: "Foo", coordinate: nil)
        
        XCTAssertEqual(location.name, "Foo") 
    }
    
    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(
            latitude: 1,
            longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        let coordinate = CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0)
        let location = Location(name: "Foo", coordinate: coordinate)
        let dictionary: [String : Any] = [ "name" : "Foo",
                                           "latitude" : 10.0,
                                           "longitude" : 10.0]
        let createdLocation = Location(dict: dictionary)
        
        XCTAssertEqual(location, createdLocation)
    }
    
    func testCanBeSerializedIntoDictionary() {
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2D(latitude: 10.0, longitude: 10.0))
        
        let generatedLocation = Location(dict: location.dict)
        
        XCTAssertEqual(location, generatedLocation)
    }
}
