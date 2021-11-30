//
//  CustomCell.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/13/21.
//

import UIKit

class CustomCell: UITableViewCell{

    var restaurants: Restaurants?
    var image: UIImage?
    var locationName: String?
    var categoryType: String?
    
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
   
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!

    
    //var storedFavorites: [FavoritedCity] = UserDefaults.standard.object(forKey: "favPlaces") as? [FavoritedCity] ?? []
//    var storedFavorites: [FavoritedCity] = []
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   // let favoritePlaceList = favoriteListClass()
    
    
    @IBAction func insertFav(_ sender: Any) {

        favButton.setImage(UIImage(named:"starAfter"), for: UIControl.State.normal) ///also the add button works but it changes the image for multiple cells instead of just the one we clicked. not sure how to fix this  but i know it is something to do with UIControl.State.normal. Not a pressing issue tho bc  it is correctly adding the specific name to the list
       // print(locationName)
        //print(categoryType)

        //source for below code: https://cocoacasts.com/ud-5-how-to-store-a-custom-object-in-user-defaults-in-swift
        
        
        //let cityArray = try? JSONDecoder().decode([FavoritedCity].self, from: storedData!)
        var cityExists = false
        var cityIndex = 0
        
        if let data = UserDefaults.standard.data(forKey: "favPlaces") {
            
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                var storedFavorites = try decoder.decode([FavoritedCity].self, from: data)
                
                for (index, place) in storedFavorites.enumerated()
                    {
                        if place.cityName == locationName
                        {
                            cityExists = true
                            cityIndex = index
                        }
                    }
                    if cityExists
                    {
                        if categoryType == "restaurants"
                        {
                            storedFavorites[cityIndex].restaurants.append(nameLabel.text ?? "")
                        }
                        if categoryType == "hotels"
                        {
                            storedFavorites[cityIndex].hotels.append(nameLabel.text ?? "")
                        }
                        if categoryType == "landmarks"
                        {
                            storedFavorites[cityIndex].landmarks.append(nameLabel.text ?? "")
                        }
                        storedFavorites[cityIndex].allPlaces.append(nameLabel.text ?? "")
                        do {
                            // Create JSON Encoder
                            let encoder = JSONEncoder()

                            // Encode Note
                            let data = try encoder.encode(storedFavorites)
                            UserDefaults.standard.set(data, forKey: "favPlaces")
                            //print(storedFavorites)

                        } catch {
                            print("Unable to Encode Note (\(error))")
                        }
                        //UserDefaults.standard.set(storedFavorites, forKey: "favPlaces")
                        for item in storedFavorites {
                            print (item.restaurants)
                        }
                    }
                    else
                    {
                        var currCity = FavoritedCity()
                        currCity.cityName = locationName!
                        if categoryType == "restaurants"
                        {
                            currCity.restaurants.append(nameLabel.text ?? "")
                        }
                        if categoryType == "hotels"
                        {
                            currCity.hotels.append(nameLabel.text ?? "")
                        }
                        if categoryType == "landmarks"
                        {
                            currCity.landmarks.append(nameLabel.text ?? "")
                        }
                        currCity.allPlaces.append(nameLabel.text ?? "")
                        do {
                            // Create JSON Encoder
                            let encoder = JSONEncoder()

                            // Encode Note
                            storedFavorites.append(currCity)
                            let data = try encoder.encode(storedFavorites)
                            UserDefaults.standard.set(data, forKey: "favPlaces")
                            
                        } catch {
                            print("Unable to Encode Note (\(error))")
                        }
                        //UserDefaults.standard.set(storedFavorites, forKey: "favPlaces")
                    }
                
            } catch {
                print("Unable to Decode Notes (\(error))")
            }

        }
        
        

      //  favoritePlaceList.insertPlace(placeName: nameLabel.text!)
        
       // print(favoritePlaceList)
        // essentially we wanted to add a location to the My Trips tab and when a user clicks on the location, they can see what they have added. or under each location it shows what they have added. either way.
    }

}
