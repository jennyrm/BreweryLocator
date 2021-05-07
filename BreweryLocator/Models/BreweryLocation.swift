//
//  Location.swift
//  BreweryLocator
//
//  Created by Jenny Morales on 5/4/21.
//

import UIKit

struct Location: Decodable {
    var zipCode: String
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
    }
}//End of struct

struct Brewery: Decodable {
    var name: String?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var websiteURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case street
        case city
        case state
        case zipCode = "postal_code"
        case websiteURL = "website_url"
    }
}


