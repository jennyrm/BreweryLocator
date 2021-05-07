//
//  LocationError.swift
//  BreweryLocator
//
//  Created by Jenny Morales on 5/4/21.
//

import UIKit

enum LocationError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(let error):
            print(error.localizedDescription)
            return "That location does not exist\nPlease check your spelling"
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responded with bad data. Blame the back end team, not the front end"
        }
    }
}//End of enum
