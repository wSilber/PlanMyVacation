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
    
    let API_KEY = "hWP1FMQbuRIU3Hvtt9_RMCJqFloDAhUoXyjw18nHWZJ9UrvAY9IOzU5zqZWN0FL3T8CtyXsNheVGCZT5ffZfD9ziVnvwKji0PnRX6na9ehtp8ev-kue9axtOYpCNYXYx"
    
    
    struct APIResults: Decodable {
        var id: Int
        var name: String
    }
    
    struct Business: Decodable {
        var rating: Int
        var price: String
        var phone: String
        var id: String
        var alias: String
        var isClosed: Bool
        var categories: [String]
        var reviewCount: Int
        var name: String
        var url: String
        var coordinates: [Int]
        var distance: Int
        var transactions: [String]
    }
    
    struct APIBusinessesResult: Decodable {
        var total: Int
        var buisinesses: [Business]
        var region: [String: [String:Int]]
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
        let urlPath = String(format:"https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972")
        let urlPath2 = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let safeUrlPath = urlPath2 {
            let url = URL(string: safeUrlPath)
            guard let fetchURL = url else { return }
            var request = URLRequest(url: fetchURL)
            request.httpMethod = "GET"
            request.addValue("Bearer \(API_KEY)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                print("ANyTHING")
                if(error != nil) {
                    print("ERORR");
                    return;
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                if(httpResponse.statusCode != 200) {
                    print("Could not get results from api")
                    return
                }
                
                guard let safeData = data else { return }
                do {
                    let result = try JSONDecoder().decode(APIBusinessesResult.self, from: safeData)
                    print(result)
                } catch {
                    print("ERROR: Could not parse data from api results")
                }
                
            })
            task.resume()

        }
    }
}
