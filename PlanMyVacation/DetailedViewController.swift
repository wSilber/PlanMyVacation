//
//  DetailedViewController.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/21/21.
//

import UIKit
import Foundation
import MapKit
import CoreLocation

class DetailedViewController: UIViewController {
    var restaurants: Restaurants?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let imageFrame = CGRect(x: view.frame.midX-150, y: 125, width: 300, height: 275)
        let imageView = UIImageView(frame: imageFrame)

        if let imagePath = restaurants!.imageURL {
            if let imageurll = URL(string: imagePath){
            let data = try? Data(contentsOf: imageurll)
            let image = UIImage(data:data!)
            imageView.image = image
            self.image = image
            }
            if URL(string: imagePath) == nil {
                imageView.image = UIImage(named: "noImageFound")
                self.image = UIImage(named: "noImageFound")
            }
        }
        view.addSubview(imageView)

        view.backgroundColor = UIColor.white
        self.title = restaurants?.name
        
        let theNameFrame = CGRect(x: view.frame.midX-150, y: 325, width: 300, height: 75)
        let nameView = UILabel(frame: theNameFrame)
        nameView.backgroundColor = UIColor(red: 76, green: 76, blue: 76, alpha: 0.80)

        if let placeName = restaurants!.name{
            nameView.text = placeName
        }
        if restaurants!.name == nil || restaurants!.name == "" {
            nameView.text = "Name: Missing Name"
        }
        nameView.font = nameView.font?.withSize(18)
        nameView.textColor = UIColor.gray
        nameView.textAlignment = .center
        nameView.baselineAdjustment = .alignCenters
        nameView.numberOfLines = 2
        view.addSubview(nameView)
        
        let theAddressFrame = CGRect(x: view.frame.midX-150, y: 400, width: 300, height: 80)
        let addressView = UITextView(frame: theAddressFrame)
        if let address = restaurants!.address {
            addressView.text = "Located at " + String(address)
        }
        if restaurants!.address == nil || restaurants!.address == "" {
            addressView.text = "Address: Unavailable"
        }
        addressView.textAlignment = .center
        addressView.font = addressView.font?.withSize(15)
        addressView.backgroundColor = UIColor(red: 76, green: 76, blue: 76, alpha: 0.80)
        view.addSubview(addressView)
        
        
        
        
        let yelpURLFrame = CGRect(x: view.frame.midX-90, y: 440, width: 100, height: 80)
        let theURLView = UIButton(frame: yelpURLFrame)
        theURLView.setImage(UIImage(named:"yelpURL"), for: .normal)
        theURLView.addTarget(self, action: #selector(openYelpURL(_:)), for: .touchUpInside)
        view.addSubview(theURLView)

        let reviewButtonFrame = CGRect(x: view.frame.midX+20, y: 440, width: 100, height: 80)
        let theReviewButtonView = UIButton(frame: reviewButtonFrame)
        theReviewButtonView.setImage(UIImage(named:"reviewButton"), for: .normal)
        theReviewButtonView.addTarget(self, action: #selector(getReviews(_:)), for: .touchUpInside)
        view.addSubview(theReviewButtonView)
        
        
        let addInfoFrame = CGRect(x: view.frame.midX-150, y: 525, width: 300, height: 80)
        let addInfoView = UITextView(frame: addInfoFrame)
        addInfoView.text = "ADDITIONAL INFOMRATION"
        addInfoView.textAlignment = .center
        addInfoView.textColor = UIColor.darkGray
        addInfoView.font = addInfoView.font?.withSize(22)
        
        view.addSubview(addInfoView)
        
        
        
        
        let isClosedFrame = CGRect(x: view.frame.midX-150, y:550, width: 300, height: 50)
        let isClosedView = UILabel(frame: isClosedFrame)
        if let boolisclosed = restaurants!.is_closed {
        if(boolisclosed == false){
            isClosedView.text = " Open? This place is open."
        }
        else{
            isClosedView.text = " Open? This place is permanently closed."
        }
        }
        if restaurants!.is_closed == nil || (restaurants!.is_closed != true && restaurants!.is_closed != false) {
            isClosedView.text = " Open? Info is unavailable"
        }
        isClosedView.font = isClosedView.font?.withSize(15.5)
//        isClosedView.textColor = UIColor.black
        isClosedView.textAlignment = .left
        isClosedView.baselineAdjustment = .alignCenters
        isClosedView.numberOfLines = 1
        view.addSubview(isClosedView)

        let theRatingFrame = CGRect(x: view.frame.midX-150, y: 600, width: 150, height: 50)
        let ratingView = UITextView(frame: theRatingFrame)
        if let rating = restaurants!.rating {
            ratingView.text = "Rating? " + String(rating) + "/5.0"
        }
        if restaurants!.rating == nil || restaurants!.rating!.isNaN == true {
            ratingView.text = "Rating? Unavailable"
        }
        ratingView.font = ratingView.font?.withSize(15.5)
        view.addSubview(ratingView)
        
        let thePriceFrame = CGRect(x: view.frame.midX-150, y: 635, width: 300, height: 50)
        let priceView = UITextView(frame: thePriceFrame)
        
        if let priceofBusiness = restaurants!.price{
        if(priceofBusiness == "$"){
            priceView.text = "Price Level? " + "Inexpensive, $10 and under"
        }
        
        if(priceofBusiness == "$$"){
            priceView.text = "Price Level? " + "Moderately expensive, between $10-$25"
        }
        
        if(priceofBusiness == "$$$"){
            priceView.text = "Price Level? " + "Expensive, between $25-$45"
        }
        
        if(priceofBusiness == "$$$$"){
            priceView.text = "Price Level? " + "Very Expensive, greater than $50"
        }
        }
        if restaurants!.price == nil || restaurants!.price == "" {
            priceView.text = "Price Level? Unavailable"
        }
        priceView.font = priceView.font?.withSize(15.5)
        view.addSubview(priceView)
        
      
       
       
        
        
        
        let thePhoneFrame = CGRect(x: view.frame.midX-150, y: 680, width: 300, height: 100)
        let thePhoneView = UILabel(frame: thePhoneFrame)
        if let phoneNumber = restaurants!.phone {
            thePhoneView.text = "To visit the place please call " + String(phoneNumber)
        }
        if restaurants!.phone == nil || restaurants!.phone == "" {
            thePhoneView.text = "The phone number is unavailable. Press the Yelp button for details."
        }
        thePhoneView.font = thePhoneView.font?.withSize(17)
        thePhoneView.textColor = UIColor.lightGray
        thePhoneView.textAlignment = .center
        thePhoneView.baselineAdjustment = .alignCenters
        thePhoneView.numberOfLines = 2
        view.addSubview(thePhoneView)
        
      
        
        
        
        
        
        let helpButtonFrame = CGRect(x: view.frame.midX+100, y: 100, width: 70, height: 70)
        let helpButtonView = UIButton(frame: helpButtonFrame)
        helpButtonView.setImage(UIImage(named:"helpButton"), for: .normal)
        helpButtonView.addTarget(self, action: #selector(helpButton(_:)), for: .touchUpInside)
        view.addSubview(helpButtonView)

//
//        let theReviewsFrame = CGRect(x: view.frame.midX-150, y: 400, width: 300, height: 80)
//        let theReviewView = UITextView(frame: theReviewsFrame)
//        if let reviewObj = restaurants!.reviews {
//            print("reviewObj")
//            print(reviewObj)
//            theReviewView.text = "Review 1 " + (reviewObj[0] as! String) +
//                "Review 2 " + (reviewObj[1] as! String) +
//                "Review 3 " + (reviewObj[2] as! String)
//        }
//        if restaurants!.reviews == nil {
//            theReviewView.text = "Reviews: Unavailable"
//        }
//        theReviewView.font = theReviewView.font?.withSize(15)
//        view.addSubview(theReviewView)
//
        
//        if let url = restaurants!.url {
//            theURLView.text = "URL: " + String(url)
//        }
//        if restaurants!.url == nil || restaurants!.url == "" {
//            thePhoneView.text = "URL: Unavailable"
//        }
//        theURLView.font = theURLView.font?.withSize(18)
//        let hoursFrame = CGRect(x: view.frame.midX-150, y: 500, width: 300, height: 80)
//        let theHoursView = UITextView(frame: hoursFrame)
//        //addressView.backgroundColor = UIColor.blue
//        theHoursView.text = "Hours: " + String((restaurants?.hours?[0])!) + String((restaurants?.hours?[1])!)
//        theHoursView.font = theHoursView.font?.withSize(18)
//        view.addSubview(theHoursView)

        // Do any additional setup after loading the view.
    }
    

    let alert = UIAlertController(title: "OK", message: "There is no Yelp URL for this place", preferredStyle: .alert)
    
    @objc func openYelpURL(_ sender: UIButton) {
        sender.setImage(UIImage(named: "YelpURL2"), for: UIControl.State.normal)
        if let myUrl = restaurants!.url{
            UIApplication.shared.open(URL(string: "\(myUrl)")!)
            //https://stackoverflow.com/questions/42389649/openurl-was-deprecated-in-ios-10-0-please-use-openurloptionscompletionhandl
        }
        if restaurants!.url == nil || restaurants!.url == "" {
            alert.addAction(UIAlertAction(title: "No URL", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    

    
    func retrieveAPIReviews(completionHandler: @escaping ([Reviews]?, Error?) -> Void) {
        print("getAPIReviews funtion")

        if let resId = restaurants?.id {
            print("valid resid")
            let apikey = "hWP1FMQbuRIU3Hvtt9_RMCJqFloDAhUoXyjw18nHWZJ9UrvAY9IOzU5zqZWN0FL3T8CtyXsNheVGCZT5ffZfD9ziVnvwKji0PnRX6na9ehtp8ev-kue9axtOYpCNYXYx"
        let baseURL = "https://api.yelp.com/v3/businesses/\(resId)/reviews"
        let url = URL(string: baseURL)
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    guard let resp = json as? NSDictionary else { return }
                    guard let reviews = resp.value(forKey: "reviews") as? [NSDictionary] else { return }
                    var reviewsList: [Reviews] = []
                    
                    for review in reviews {
                        var reviewOne = Reviews()
                        reviewOne.id = review.value(forKey: "id") as? String
                        reviewOne.text = review.value(forKey: "text") as? String
                        reviewsList.append(reviewOne)
                        //print(reviewsList)
                    }
                    completionHandler(reviewsList, nil)
                } catch {
                    print("Caught error")
                    completionHandler(nil, error)
                }
            }.resume()
    }
    }
 
    
        var reviews1: [Reviews] = []
        @objc func getReviews(_ sender: UIButton) {
            sender.setImage(UIImage(named: "reviewButton2"), for: UIControl.State.normal)
            retrieveAPIReviews(){(response, error) in
                if let response = response {
                    self.reviews1 = response
                    DispatchQueue.main.async {
                        let modalVC = ReviewModalView()
                        modalVC.modalPresentationStyle = .overCurrentContext
                        modalVC.reviewsModal = self.reviews1
                        self.present(modalVC, animated: false)
                    }
                }
            }
            print("reviews \(self.reviews1)")

//            let modalVC = ReviewModalView()
//            modalVC.reviewsModal = self.reviews
//            print("indetailed reviews \(reviews)")
//            print("indetailed modal \(modalVC.reviewsModal)")
//            modalVC.modalPresentationStyle = .overCurrentContext
//            self.present(modalVC, animated: false)
        }
            
           
    @objc func helpButton(_ sender: UIButton) {
        sender.setImage(UIImage(named: "helpButton2"), for: UIControl.State.normal)
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }


        /*
                if let resId = restaurants?.id {
                    print("valid resid")
                    let apikey = "hWP1FMQbuRIU3Hvtt9_RMCJqFloDAhUoXyjw18nHWZJ9UrvAY9IOzU5zqZWN0FL3T8CtyXsNheVGCZT5ffZfD9ziVnvwKji0PnRX6na9ehtp8ev-kue9axtOYpCNYXYx"
                let baseURL = "https://api.yelp.com/v3/businesses/\(resId)/reviews"
                let url = URL(string: baseURL)
                var request = URLRequest(url: url!)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                request.httpMethod = "GET"
        
        /*
                Foundation.URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if let err = error {
                        print(err.localizedDescription)
                        }
                        do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                        print(">>>>>", json, #line, "<<<<<<<<<")
                        } catch {
                        print("caught")
                        }
                        }.resume()
                        }
        */
            
    //try 2
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    guard let resp = json as? NSDictionary else { return }
                    guard let reviews = resp.value(forKey: "reviews") as? [NSDictionary] else { return }
                    var reviewsList: [Reviews] = []

                    for review in reviews {
                        var reviewOne = Reviews()
                        reviewOne.id = review.value(forKey: "id") as? String
                        reviewOne.text = review.value(forKey: "text") as? String
                        reviewsList.append(reviewOne)
                        reviewid = (reviewOne.id)!
                        print("1 \(reviewid)")
                        reviewtext = (reviewOne.text)!
                        print("2 \(reviewtext)")
                    }
                } catch {
                    print("Caught error")
                }
            }.resume()

            reviewID.text = reviewid
            print("3 \(reviewid)")

            reviewText.text = reviewtext
            print("4 \(reviewtext)")
            view.addSubview(reviewText)
            view.addSubview(reviewID)
        */
    
    //ModalView
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
            return view
        }()
    let maxDimmedAlpha: CGFloat = 0.6
        lazy var dimmedView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.alpha = maxDimmedAlpha
            return view
        }()
        
        let defaultHeight: CGFloat = 300
 
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
                dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    //source: https://betterprogramming.pub/how-to-present-a-bottom-sheet-view-controller-in-ios-a5a3e2047af9
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func animatePresentContainer() {
        // Update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func setupConstraints() {
            // 4. Add subviews
            view.addSubview(dimmedView)
            view.addSubview(containerView)
            dimmedView.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                // set container static constraint (trailing & leading)
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
            
            containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
            containerViewHeightConstraint?.isActive = true
            containerViewBottomConstraint?.isActive = true
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
