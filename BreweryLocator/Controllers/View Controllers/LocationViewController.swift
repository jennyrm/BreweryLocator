//
//  ViewController.swift
//  BreweryLocator
//
//  Created by Jenny Morales on 5/4/21.
//

import UIKit

class LocationViewController: UIViewController {

    
    @IBOutlet weak var breweryNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func button(_ sender: Any) {
        BreweryLocationController.fetchLocation { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    self?.fetchImageAndUpdateViews(for: location)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchImageAndUpdateViews(for location: String) {
        BreweryLocationController.fetchBrewery(for: location) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let brewery):
                    print(brewery)
//                    self?.breweryNameLabel.text = brewery
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//End of class

