//
//  DetailedViewController.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/21/21.
//

import UIKit

class DetailedViewController: UIViewController {
    var restaurants: Restaurants?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageFrame = CGRect(x: view.frame.midX-150, y: 500, width: 300, height: 250)
        let imageView = UIImageView(frame: imageFrame)
        //let imagePath = restaurants!.imageURL!

        if let imagePath = restaurants!.imageURL {
            let imageurll = URL(string: imagePath)
            let data = try? Data(contentsOf: imageurll!)
            let image = UIImage(data:data!)
            imageView.image = image
            self.image = image
        }
        view.addSubview(imageView)

        view.backgroundColor = UIColor.white
        self.title = restaurants?.name
        self.title = restaurants?.price
        
        let theNameFrame = CGRect(x: view.frame.midX-150, y: 150, width: 300, height: 100)
        let nameView = UITextView(frame: theNameFrame)
        //nameView.backgroundColor = UIColor.blue
        nameView.text = "Name: " + (restaurants!.name!)
        nameView.font = nameView.font?.withSize(25)
        view.addSubview(nameView)
        
        let favoriteFrame = CGRect(x: view.frame.midX+100, y: 125, width: 60, height: 60)
        let favView = UIButton(frame: favoriteFrame)
        favView.setImage(UIImage(named: "starBefore"), for: .normal)
        favView.addTarget(self, action: #selector(insertfavoritePlace(_:)), for: .touchUpInside)
        view.addSubview(favView)
        
        let thePriceFrame = CGRect(x: view.frame.midX-150, y: 250, width: 300, height: 50)
        let priceView = UITextView(frame: thePriceFrame)
        
        if let priceofBusiness = restaurants!.price{
        if(priceofBusiness == "$"){
            priceView.text = "Price Level: " + "Inexpensive, $10 and under"
        }
        
        if(priceofBusiness == "$$"){
            priceView.text = "Price Level: " + "Moderately expensive, between $10-$25"
        }
        
        if(priceofBusiness == "$$$"){
            priceView.text = "Price Level: " + "Expensive, between $25-$45"
        }
        
        if(priceofBusiness == "$$$$"){
            priceView.text = "Price Level: " + "Very Expensive, greater than $50"
        }
        }
        if restaurants!.price == nil || restaurants!.price == "" {
            priceView.text = "Price Level: Unavailable"
        }
        
        priceView.font = priceView.font?.withSize(18)
        view.addSubview(priceView)
        
        let theRatingFrame = CGRect(x: view.frame.midX-150, y: 300, width: 150, height: 50)
        let ratingView = UITextView(frame: theRatingFrame)
        if let rating = restaurants!.rating {
            ratingView.text = "Rating: " + String(rating) + "/5.0"
        }
        if restaurants!.rating == nil || restaurants!.rating!.isNaN == true {
            ratingView.text = "Rating: Unavailable"
        }
        
        ratingView.font = ratingView.font?.withSize(18)
        view.addSubview(ratingView)
        
        let theAddressFrame = CGRect(x: view.frame.midX-150, y: 350, width: 300, height: 80)
        let addressView = UITextView(frame: theAddressFrame)
        if let address = restaurants!.address {
            addressView.text = "Address: " + String(address)
        }
        if restaurants!.address == nil || restaurants!.address == "" {
            addressView.text = "Address: Unavailable"
        }
        addressView.font = ratingView.font?.withSize(18)
        view.addSubview(addressView)
        
        let thePhoneFrame = CGRect(x: view.frame.midX-150, y: 400, width: 300, height: 80)
        let thePhoneView = UITextView(frame: thePhoneFrame)
        if let phoneNumber = restaurants!.phone {
            thePhoneView.text = "Phone Number: " + String(phoneNumber)
        }
        if restaurants!.phone == nil || restaurants!.phone == "" {
            thePhoneView.text = "Phone Number: Unavailable"
        }
        thePhoneView.font = thePhoneView.font?.withSize(18)
        view.addSubview(thePhoneView)
        
        let isClosedFrame = CGRect(x: view.frame.midX-150, y: 450, width: 300, height: 50)
        let isClosedView = UITextView(frame: isClosedFrame)
        if let boolisclosed = restaurants!.is_closed {
        if(boolisclosed == false){
            isClosedView.text = "Permanently Closed? " +
            "Open!"
        }
        else{
            isClosedView.text = "Permanently Closed? " +
            "Closed"
        }
        }
        if restaurants!.is_closed == nil || (restaurants!.is_closed != true && restaurants!.is_closed != false) {
            isClosedView.text = "Permanently Closed? " +
                "Unavailable"
        }
        isClosedView.font = isClosedView.font?.withSize(18)
        
        
        
        
        
//        let hoursFrame = CGRect(x: view.frame.midX-150, y: 500, width: 300, height: 80)
//        let theHoursView = UITextView(frame: hoursFrame)
//        //addressView.backgroundColor = UIColor.blue
//        theHoursView.text = "Hours: " + String((restaurants?.hours?[0])!) + String((restaurants?.hours?[1])!)
//        theHoursView.font = theHoursView.font?.withSize(18)
//        view.addSubview(theHoursView)

        view.addSubview(isClosedView)

        // Do any additional setup after loading the view.
    }
    
    @objc func insertfavoritePlace(_ sender: UIButton){
        sender.setImage(UIImage(named: "starAfter"), for: UIControl.State.normal)
        //INSERT MOVIE INTO LIST
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
