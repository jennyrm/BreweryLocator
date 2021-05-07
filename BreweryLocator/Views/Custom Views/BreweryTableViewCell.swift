//
//  BreweryTableViewCell.swift
//  BreweryLocator
//
//  Created by Jenny Morales on 5/5/21.
//

import UIKit

//MARK: - Protocol
protocol BreweryTableViewCellDelegate: class {
    func favoritedWasToggled(sender: BreweryTableViewCell)
}
//MARK: - Class
class BreweryTableViewCell: UITableViewCell {
    //MARK: - Out
    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var breweryStreetLabel: UILabel!
    @IBOutlet weak var breweryCityStateZipLabel: UILabel!
    @IBOutlet weak var breweryWebsiteURLLabel: UILabel!
    
    //MARK: - Properties
    weak var delegate: BreweryTableViewCellDelegate?
    var brewery: Brewery? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions
    @IBAction func isFavoritedButtonToggled(_ sender: UIButton) {
        delegate?.favoritedWasToggled(sender: self)
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let brewery = brewery else { return }
        breweryNameLabel.text = brewery.name
        breweryStreetLabel.text = brewery.street ?? "No Street Address Available"
        breweryCityStateZipLabel.text = "\(brewery.city!), \(brewery.state!) \(brewery.zipCode!)"
        breweryWebsiteURLLabel.text = brewery.websiteURL
    }
    
    
}//End of class

