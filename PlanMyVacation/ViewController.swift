//
//  ViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 11/10/21.
//

// AS OF RIGHT NOW WE STILL HAVE MORE SOURCES TO CITE AND THE CODE NEEDS TO BE CLEANED UP. THIS IS SOLELY FOR THE SUBMISSION FOR THE UPDATE VIDEO. ALL SOURCES WILL BE CITED FOR FINAL SUBMISSION!!!!

import UIKit
import MapKit
import CoreLocation
import Foundation


class ViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var CPlatitude: Double = 38.627003
    var CPlongitude: Double = -90.19940200
    var location = CLLocation(latitude: 38.627003, longitude: -90.19940200)

    
    var restaurants: [Restaurants] = []
    var favoritesViewController: [Restaurants] = []
    
    var searchText : String = ""
    var categories: String = "restaurants"
    var locationInput: String = ""

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var categoryRHL: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsersClosestCity()
        searchBar.placeholder = "Search a Location"
        locationManager.startUpdatingLocation()
        
        searchBar.delegate = self

        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
  
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        restaurantsTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        selectCategory(categoryRHL)
        categoryRHL.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        
        alert.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    let alert = UIAlertController(title: "Get Started!", message: "Explore Restaurants, Hotels, and Landmarks near you by clicking the slider or simply search a location!", preferredStyle: .alert)

    
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        CPlatitude = locValue.latitude
        CPlongitude = locValue.longitude
        location = CLLocation(latitude: CPlatitude, longitude: CPlongitude)
//        print("locationManager \(location)")
    }

    func setUsersClosestCity(){
    //https://stackoverflow.com/questions/47987473/addressdictionary-is-deprecated-first-deprecated-in-ios-11-0-use-properties
    let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { [self] (placemarksArray, error) in
//                print(placemarksArray!)
                if (error) == nil {
                    if placemarksArray!.count > 0 {
                        let placemark = placemarksArray?[0]
                        _ = "\(placemark?.subThoroughfare ?? ""), \(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")";
                        if let userlocation = placemark?.locality {
                            let userlocation = String(userlocation.filter { !" \n\t\r".contains($0) })
                            self.locationInput = userlocation
//                            print("setUsersClosesCity \(locationInput)")
                        }
                    }
                }

            }
    }
    
    @IBAction func selectCategory(_ sender: UISegmentedControl) {
//        print("selectCategory \(locationInput)")

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
//            print("selectCategory \(locationInput)")

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
                           limit: 25, sortBy: "distance", locale: "en_US") { (response, error) in
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
//    print("selectCategory \(locationInput)")
}
    var searchedCity : String = ""
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
//        print("entered")
        if let text = searchBar.text{
            searchedCity = text
            let text1 = String(text.filter { !" \n\t\r".contains($0) })
//            print(text1)
            locationInput = text1
//            print(text)
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
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        restaurants[indexPath.row].location = searchedCity
        if let ratingnotnill = restaurants[indexPath.row].rating {
        let ratinglabel = String(format: "%.1f",ratingnotnill)
        cell.distanceLabel.text = "Rating: " + String(ratinglabel) + "/5.0"
        //priceView.font = priceView.font?.withSize(18)
        cell.distanceLabel.font = cell.distanceLabel.font?.withSize(13)
        }
        if (restaurants[indexPath.row].rating == nil){
            cell.distanceLabel.text = ""
        }
        
        //cell.distanceLabel.text = "Distance: " + dist + " miles"
        cell.clipsToBounds = true

        //cell.ratingLabel.text = String(restaurants[indexPath.row].rating ?? 0.0)
        //cell.priceLabel.text = restaurants[indexPath.row].price ?? "No Info"
        //cell.isClosed = restaurants[indexPath.row].is_closed ?? false
        //cell.addressLabel.text = restaurants[indexPath.row].address
        
        return cell
    }
    
    
}
