//
//  Location.swift
//  HackChallenge_
//
//  Created by Janice Lee on 5/4/21.
//

import UIKit

class Location {
    
    var locationName: String
    var category: String
    var address: String
    var info: String
    
    init(locationName: String, category: String, address: String, info: String) {
        self.locationName = locationName
        self.category = category
        self.address = address
        self.info = info
    }
}
