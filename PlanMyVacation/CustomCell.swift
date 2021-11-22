//
//  CustomCell.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/13/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var isClosedLabel: UILabel!
    
//    var isClosed: Bool = false {
//        didSet {
//            if isClosed {
//                isClosedLabel.text = "Closed"
//
//            } else {
//                isClosedLabel.text = "Open Now"
//            }
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        parentView.layer.cornerRadius = 15

    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
