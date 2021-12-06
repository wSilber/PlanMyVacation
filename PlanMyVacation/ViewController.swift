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

var launchedShortcutItem: UIApplicationShortcutItem?
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print("applicarion")
        // Override point for customization after application launch.
        
        // If the app is launched by Quick Action, then take the relevant action
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // Since, the app launch is triggered by QuicAction, block "performActionForShortcutItem:completionHandler" method from being called.
            return false
        }
        return true
    }

func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        guard let actionType = ApplicationShortcutItemType(rawValue: shortcutItem.type) else { return }
        
        switch actionType {
        case .search:
            print("Handle search action")
        case .savedItems:
            print("Handle Saved Items action")
        case .cart:
            print("Handle Cart action")
        }
    }

enum ApplicationShortcutItemType:String {
    case search     = "QuickAction.Search"
    case savedItems = "QuickAction.SavedItems"
    case cart       = "QuickAction.Cart"
}

enum ApplicationShortcutItemTitle:String {
    case search     = "Search"
    case savedItems = "Saved Items"
    case cart       = "Cart"
}

enum ApplicationShortcutItemSubTitle:String {
    case search     = "by product name"
}


func addSearchQuickAction() {
    //removeSearchQuickAction
    let searchItem = UIApplicationShortcutItem(type: ApplicationShortcutItemType.search.rawValue,
                                                   localizedTitle: ApplicationShortcutItemTitle.search.rawValue,
                                                   localizedSubtitle: ApplicationShortcutItemSubTitle.search.rawValue,
                                                   icon: UIApplicationShortcutIcon(type: .update),
                                                   userInfo: nil)
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        shortcutItems.append(searchItem)
        UIApplication.shared.shortcutItems = shortcutItems
    }

func removeSearchQuickAction() {
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        for (index, item) in shortcutItems.enumerated() {
            if item.type == ApplicationShortcutItemType.search.rawValue {
                shortcutItems.remove(at: index)
            }
        }
        UIApplication.shared.shortcutItems = shortcutItems
    }

class ViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var CPlatitude: Double = 47.606209
    var CPlongitude: Double = -122.332069
    var location = CLLocation(latitude: 38.627003, longitude: -90.19940200)
    
    var restaurants: [Restaurants] = []
    var favoritesViewController: [Restaurants] = []
    
    var searchText : String = ""
    var categories: String = "restaurants"
    var locationInput: String = ""

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var categoryRHL: UISegmentedControl!
    
//    var storedFavorites: [FavoritedCity] = [] as! [FavoritedCity]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
      self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
      self.locationManager.requestWhenInUseAuthorization()

      if CLLocationManager.locationServicesEnabled() {
          locationManager.delegate = self
          locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
          locationManager.startUpdatingLocation()
      }
        
        searchBar.delegate = self
        searchBar.placeholder = "Search a Location"
        
        locationManager.startUpdatingLocation()
        setUsersClosestCity()

          restaurantsTableView.delegate = self
          restaurantsTableView.dataSource = self
          restaurantsTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
          
          selectCategory(categoryRHL)
          categoryRHL.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
          
          alert.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: nil))
          self.present(alert, animated: true)
          
          let temp: FavoritedCity = FavoritedCity()
          temp.cityName = "Select A City"
          let storedFavorites: [FavoritedCity] = [temp]
          do {
              // Create JSON Encoder
              let encoder = JSONEncoder()

              // Encode Note
              let data = try encoder.encode(storedFavorites)
              UserDefaults.standard.set(data, forKey: "favPlaces")
              print(storedFavorites)

          } catch {
              print("Unable to Encode Note (\(error))")
          }
    }
    
    let alert = UIAlertController(title: "Get Started!", message: "Explore Restaurants, Hotels, and Landmarks near you by clicking the slider or simply search a location!", preferredStyle: .alert)
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        CPlatitude = locValue.latitude
        CPlongitude = locValue.longitude
        location = locations.first ?? CLLocation(latitude: 38.627003, longitude: -90.19940200)
        print("location \(String(describing: locations.first))")
        setUsersClosestCity()
    }

    func setUsersClosestCity(){
    //https://stackoverflow.com/questions/47987473/addressdictionary-is-deprecated-first-deprecated-in-ios-11-0-use-properties
    print("setusersclosestcity \(location)")
    let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { [self] (placemarksArray, error) in
                if (error) == nil {
                    if placemarksArray!.count > 0 {
                        let placemark = placemarksArray?[0]
                        _ = "\(placemark?.subThoroughfare ?? ""), \(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")";
                        if let userlocation = placemark?.locality {
                            let userlocation = String(userlocation.filter { !" \n\t\r".contains($0) })
                            self.locationInput = userlocation
                            print("userlocation \(userlocation)")
                            print("locationinput \(locationInput)")
                        }
                    }
                }

            }
    }
    
    @IBAction func selectCategory(_ sender: UISegmentedControl) {
        if categoryRHL.selectedSegmentIndex == 0 {
            categories = "restaurants"
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
}
    var searchedCity : String = ""
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if let text = searchBar.text{
            searchedCity = text
            let text1 = String(text.filter { !" \n\t\r".contains($0) })
            locationInput = text1
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
        self.searchBar.endEditing(true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath , animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailedVC = DetailedViewController()
//        detailedVC.restaurants = restaurants[indexPath.row]
//        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        detailedVC.restaurants = restaurants[indexPath.row]
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.accessoryType = .detailButton
        cell.nameLabel.text = restaurants[indexPath.row].name
        restaurants[indexPath.row].location = searchedCity
        if let ratingnotnill = restaurants[indexPath.row].rating {
        let ratinglabel = String(format: "%.1f",ratingnotnill)
        cell.distanceLabel.text = "Rating: " + String(ratinglabel) + "/5.0"
        cell.distanceLabel.font = cell.distanceLabel.font?.withSize(13)
        }
        if (restaurants[indexPath.row].rating == nil){
            cell.distanceLabel.text = ""
        }
        cell.clipsToBounds = true
        cell.backgroundColor = .clear
        cell.locationName = searchBar.text
        cell.categoryType = categories
        return cell
    }
}
