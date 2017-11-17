//
//  Search.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire

class Search: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableFish: UITableView!
    @IBOutlet weak var searchFishes: UISearchBar!
    
    var refer = [[String:Any]]()
    var filter = [[]]
    var searchActive = false
    var requestAccess : Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refer.count
    }
    
    // Upon search bar it show the cell of fish based on county(Locality) and state
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell01", for: indexPath)
        let aqua = refer[indexPath.row]
        cell.textLabel?.text = aqua["commonName"] as? String
        cell.detailTextLabel?.text = aqua["locality"] as? String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lib = refer[indexPath.row]
        if let details = storyboard?.instantiateViewController(withIdentifier: "facts") as? Reference {
            details.info = lib
            navigationController?.pushViewController(details, animated: true)
        }
    }
}

// parse data to search bar
extension Search: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let splitSearch = searchText.replacingOccurrences(of: ",", with: "").components(separatedBy: " ");
        if splitSearch.count > 1 {
            requestAccess?.cancel()
            requestAccess = DatabaseInfo.shared.getFishes(searchFish: splitSearch[0], searchState: splitSearch[1], completion: { (searchedFish) in
                if let theSpecific = searchedFish {
                    self.refer = theSpecific
                    self.tableFish.reloadData()
                }
                
            })
        }
        
    }
    
}

extension String {
    
    var containsNonWhitespace: Bool {
        return !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}


