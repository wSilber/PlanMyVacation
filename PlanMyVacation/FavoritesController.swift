//
//  FavoritesController.swift
//  PlanMyVacation
//
//  Created by Katie Legan on 11/29/21.
//

import Foundation
import UIKit

class FavoritesController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    var numOfItems = 0
    var arrayToDisplay:[FavoritedCity] = [] as! [FavoritedCity]
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reached")
        if let data = UserDefaults.standard.data(forKey: "favPlaces") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let storedFavorites = try decoder.decode([FavoritedCity].self, from: data)
                numOfItems = storedFavorites.count
                arrayToDisplay = storedFavorites
                favoritesTableView.dataSource = self
                favoritesTableView.delegate = self
                favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
                favoritesTableView.reloadData()
                print("reached here")
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayToDisplay[1].restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        print("trying to display")
        print(arrayToDisplay[1].restaurants[indexPath.row])
        myCell.textLabel?.text = arrayToDisplay[1].restaurants[indexPath.row]
        return myCell
    }
}
