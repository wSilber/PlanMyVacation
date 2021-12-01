//
//  FetchBusinessData.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/13/21.
//

import Foundation

extension ViewController{
    
    func retrieveVenues(location: String,
                        category: String,
                        limit: Int,
                        sortBy: String,
                        locale: String,
                        completionHandler: @escaping ([Restaurants]?, Error?) -> Void) {
        
        let apikey = "hWP1FMQbuRIU3Hvtt9_RMCJqFloDAhUoXyjw18nHWZJ9UrvAY9IOzU5zqZWN0FL3T8CtyXsNheVGCZT5ffZfD9ziVnvwKji0PnRX6na9ehtp8ev-kue9axtOYpCNYXYx"
        
//        let baseURL = "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)&locale=\(locale)"
        
        let baseURL = "https://api.yelp.com/v3/businesses/search?location=\(location)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)&locale=\(locale)"
        
        let url = URL(string: baseURL)
        
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            do {
                
                // Read data as JSON
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                guard let resp = json as? NSDictionary else { return }

                // Businesses
                guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else { return }

                var restaurantsList: [Restaurants] = []
                
                // Accessing each business
                for business in businesses {
                    var restaurant = Restaurants()
                    restaurant.name = business.value(forKey: "name") as? String
                    restaurant.id = business.value(forKey: "id") as? String
                    restaurant.rating = business.value(forKey: "rating") as? Float
                    restaurant.price = business.value(forKey: "price") as? String
                    restaurant.is_closed = business.value(forKey: "is_closed") as? Bool
                    restaurant.distance = business.value(forKey: "distance") as? Double
                    let address = business.value(forKeyPath: "location.display_address") as? [String]
                    restaurant.address = address?.joined(separator: "\n")
                    restaurant.phone = business.value(forKey: "phone") as? String
                    restaurant.imageURL = business.value(forKey: "image_url") as? String
                    restaurant.hours = business.value(forKey: "hours") as? [String]
                    restaurant.location = business.value(forKey: "location.city") as? String
                    restaurant.url = business.value(forKey: "url") as? String

                    //STILL NEED TO CITE ABOVE CODE
                    restaurantsList.append(restaurant)
                }
                
                completionHandler(restaurantsList, nil)
                
            } catch {
                print("Caught error")
                completionHandler(nil, error)
            }
    }.resume()
}
}
