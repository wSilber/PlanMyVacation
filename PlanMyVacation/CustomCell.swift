//
//  CustomCell.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/13/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
   
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func insertFavPlace(_ sender: UIButton) {
        sender.setImage(UIImage(named: "starAfter"), for: UIControl.State.normal)
        //FAV BUTTON NOT WORKING????
        //HOW TO ADD TO LIST?????
    }

}
