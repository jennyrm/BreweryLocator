//
//  BreweryListTableViewController.swift
//  BreweryLocator
//
//  Created by Jenny Morales on 5/5/21.
//

import UIKit

class BreweryListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var brewerySearchBar: UISearchBar!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brewerySearchBar.delegate = self
        fetchLocationForTableView()
    }
    
    //MARK: - Properties
    var breweries: [Brewery] = []
    var zipCode = ""
    
    //MARK: - Functions
    func fetchLocationForTableView() {
        BreweryLocationController.fetchLocation { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let zipCode):
                    self.fetchBreweriesForTableView(zipCode)
                    self.zipCode = zipCode
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fetchBreweriesForTableView(_ location: String) {
        BreweryLocationController.fetchBrewery(for: location) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let breweries):
                    self.breweries = breweries
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function)\(#line) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breweries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath) as? BreweryTableViewCell else { return UITableViewCell() }
        let brewery = breweries[indexPath.row]
        cell.brewery = brewery
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if zipCode == "" {
            return ""
        } else {
            return "Breweries Near \(zipCode)"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}//End of class

//MARK: - Extensions
extension BreweryListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        if searchTerm.count == 5 {
            if (Int(searchTerm) != nil) {
                self.zipCode = searchTerm
                tableView.reloadData()
                fetchBreweriesForTableView(searchTerm.lowercased())
                return
            }
        }
        zipCode = ""
        tableView.reloadData()
    
        fetchBreweriesForTableView(searchTerm.lowercased())
    }
}//End of class

//MARK: - Extension
extension BreweryListTableViewController: BreweryTableViewCellDelegate {
    func favoritedWasToggled(sender: BreweryTableViewCell) {
// 
    }
}//End of extension

