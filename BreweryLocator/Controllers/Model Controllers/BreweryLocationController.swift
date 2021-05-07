//
//  LocationController.swift
//  BreweryLocator
//
//  Created by Jenny Morales on 5/4/21.
//

import UIKit

class BreweryLocationController {
    //MARK: - Properties
    static private let locationBaseURL = URL(string: "https://freegeoip.app")
    static private let formatEndPoint = "json"
    static private let breweryBaseURL = URL(string: "https://api.openbrewerydb.org/breweries/search")
//    static private let searchEndPoint = "search"
    
    //MARK: - Functions
    static func fetchLocation(completion: @escaping (Result<String, LocationError>) -> Void) {
        guard let locationBaseURL = locationBaseURL else {return completion(.failure(.invalidURL)) } //https://freegeoip.app
        let finalURL = locationBaseURL.appendingPathComponent(formatEndPoint) //https://freegeoip.app/json
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("LOCATION STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else { return completion(.failure(.noData)) }
            do {
                let location = try JSONDecoder().decode(Location.self, from: data)
                let zipCode = location.zipCode
                
                completion(.success(zipCode))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchBrewery(for location: String, completion: @escaping (Result<[Brewery], LocationError>) -> Void) {
        guard let breweryBaseURL = breweryBaseURL else { return completion(.failure(.invalidURL)) }
//        let searchURL = breweryBaseURL.appendingPathComponent(searchEndPoint)
        var components = URLComponents(url: breweryBaseURL, resolvingAgainstBaseURL: true)
        let queryItem = URLQueryItem(name: "query", value: location)
        components?.queryItems = [queryItem]
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("BREWERY STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelArray = try JSONDecoder().decode([Brewery].self, from: data)
                var arrayOfBreweries: [Brewery] = []
                
                for brewery in topLevelArray {
                    arrayOfBreweries.append(brewery)
                }
                
                completion(.success(arrayOfBreweries))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
}//End of class

