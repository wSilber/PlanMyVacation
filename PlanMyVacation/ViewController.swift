//
//  ViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 11/10/21.
//

// AS OF RIGHT NOW WE STILL HAVE MORE SOURCES TO CITE AND THE CODE NEEDS TO BE CLEANED UP. THIS IS SOLELY FOR THE SUBMISSION FOR THE UPDATE VIDEO. ALL SOURCES WILL BE CITED FOR FINAL SUBMISSION!!!!

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
//    let CPLatitude: Double = 38.627003
//    let CPLongitude: Double = -90.199402
//
    var locationInput: String = "Missouri"
    
    var restaurants: [Restaurants] = []
    
    var searchText : String = ""
    var categories: String = "restaurants"
    
    
    @IBOutlet weak var categoryRHL: UISegmentedControl!
    
    @IBAction func selectCategory(_ sender: UISegmentedControl) {
        if categoryRHL.selectedSegmentIndex == 0 {
            categories = "restaurants"
//            retrieveVenues(latitude: CPLatitude, longitude: CPLongitude, category: categories,
//                           limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
//
//                            if let response = response {
//                                self.restaurants = response
//                                DispatchQueue.main.async {
//                                    self.restaurantsTableView.reloadData()
//                                }
//                            }
//            }
            retrieveVenues(location: locationInput, category: categories,
                           limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
                            if let response = response {
                                self.restaurants = response
                                DispatchQueue.main.async {
                                    self.restaurantsTableView.reloadData()
                                }
                            }
            }
        }
        if categoryRHL.selectedSegmentIndex == 1 {
            categories = "hotels"
//            retrieveVenues(latitude: CPLatitude, longitude: CPLongitude, category: categories,
//                           limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
//
//                            if let response = response {
//                                self.restaurants = response
//                                DispatchQueue.main.async {
//                                    self.restaurantsTableView.reloadData()
//                                }
//                            }
//            }
            retrieveVenues(location: locationInput, category: categories,
                           limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
                            if let response = response {
                                self.restaurants = response
                                DispatchQueue.main.async {
                                    self.restaurantsTableView.reloadData()
                                }
                            }
            }
        }
        
        if categoryRHL.selectedSegmentIndex == 2 {
            categories = "landmarks"
//            retrieveVenues(latitude: CPLatitude, longitude: CPLongitude, category: categories,
//                           limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
//
//                            if let response = response {
//                                self.restaurants = response
//                                DispatchQueue.main.async {
//                                    self.restaurantsTableView.reloadData()
//                                }
//                            }
//            }
        
        retrieveVenues(location: locationInput, category: categories,
                       limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
                        if let response = response {
                            self.restaurants = response
                            DispatchQueue.main.async {
                                self.restaurantsTableView.reloadData()
                            }
                        }
        }
    }
}
    override func viewDidLoad() {
        searchBar.delegate = self

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //asdfasdfasdfasdf
        print("Mia made a change")
        print("simran made change again")
        print("katie made a change")
        
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        restaurantsTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        restaurantsTableView.separatorStyle = .singleLine
        
        selectCategory(categoryRHL)
        
//        retrieveVenues(latitude: CPLatitude, longitude: CPLongitude, category: categories,
//                       limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
//
//                        if let response = response {
//                            self.restaurants = response
//                            DispatchQueue.main.async {
//                                self.restaurantsTableView.reloadData()
//                            }
//                        }
//        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("entered")
        if let text = searchBar.text{
            let text1 = String(text.filter { !" \n\t\r".contains($0) })
            print(text1)
            locationInput = text1
            print(text)
        }
        retrieveVenues(location: locationInput, category: categories,
                       limit: 50, sortBy: "distance", locale: "en_US") { (response, error) in
                        if let response = response {
                            self.restaurants = response
                            DispatchQueue.main.async {
                                self.restaurantsTableView.reloadData()
                            }
                        }
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        detailedVC.restaurants = restaurants[indexPath.row]
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        //cell.ratingLabel.text = String(restaurants[indexPath.row].rating ?? 0.0)
        //cell.priceLabel.text = restaurants[indexPath.row].price ?? "No Info"
        //cell.isClosed = restaurants[indexPath.row].is_closed ?? false
        //cell.addressLabel.text = restaurants[indexPath.row].address
        
        return cell
    }
    
    
}
