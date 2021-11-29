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
    
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
   
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let favoritePlaceList = favoriteListClass()
    
    
    @IBAction func insertFav(_ sender: Any) {
        favButton.setImage(UIImage(named:"starAfter"), for: UIControl.State.normal) ///also the add button works but it changes the image for multiple cells instead of just the one we clicked. not sure how to fix this  but i know it is something to do with UIControl.State.normal. Not a pressing issue tho bc  it is correctly adding the specific name to the list
        
        favoritePlaceList.insertPlace(placeName: nameLabel.text!)
        
        print(favoritePlaceList)
        // essentially we wanted to add a location to the My Trips tab and when a user clicks on the location, they can see what they have added. or under each location it shows what they have added. either way.
    }

}
