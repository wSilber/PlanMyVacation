//
//  HomePage.swift
//  PlanMyVacation
//
//  Created by Mia Anastasio on 11/11/21.
//

import Foundation
import UIKit

class HomePage: ViewController, UISearchBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    struct APIResults: Decodable {
        var id: Int
        var name: String
    }
    
    override func viewDidLoad() {
        print("loaded")
        searchBar.delegate = self
        tableView.delegate = self
        
    }
    enum filters {
        case Hotels
        case Restaurants
        case Landmarks
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            var currFilter = filters.Hotels
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                currFilter = filters.Hotels
                fetchData(currFilter: currFilter)
                print("in hotels")
            case 1:
                currFilter = filters.Restaurants
                print("in restaurants")
            case 2:
                currFilter = filters.Landmarks
                print("in landmarks")
            default:
                currFilter = .Hotels
            }
            print("you searched something. you searched: " + searchText)
        }
    }
    
    func fetchData(currFilter: filters) {
        let urlPath = String(format:"https://api.yelp.com/v3/businesses/search")
        let urlPath2 = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let safeUrlPath = urlPath2 {
            let url = URL(string: safeUrlPath)
            let data = try! Data(contentsOf: url!)
            
            let results = try! JSONDecoder().decode(APIResults.self, from: data)
            
            print("results is: \(results)")
        }
    }
}
