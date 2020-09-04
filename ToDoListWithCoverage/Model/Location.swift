//
//  Location.swift
//  ToDoListWithCoverage
//
//  Created by Lucky on 04.09.2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {
        
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location: Equatable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard
            rhs.coordinate?.latitude == lhs.coordinate?.latitude
                &&
                lhs.coordinate?.longitude == rhs.coordinate?.longitude
                &&
                lhs.name == rhs.name else { return false }
        return true
    }
}
