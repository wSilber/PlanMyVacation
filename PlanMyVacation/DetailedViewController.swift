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
//    let REVIEWSFRAME = CGRect(x: 150, y: 150, width: 500, height: 500)
//    let REVIEWSVIEW = UIView(frame: REVIEWSFRAME)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
        
        let imageFrame = CGRect(x: view.frame.midX-150, y: 500, width: 300, height: 250)
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
        
        let theNameFrame = CGRect(x: view.frame.midX-150, y: 150, width: 300, height: 100)
        let nameView = UITextView(frame: theNameFrame)
        //nameView.backgroundColor = UIColor.blue
        if let placeName = restaurants!.name{
            nameView.text = "Name: " + (placeName)
        }
        if restaurants!.name == nil || restaurants!.name == "" {
            nameView.text = "Name: Missing Name"
        }
        nameView.font = nameView.font?.withSize(25)
        view.addSubview(nameView)
        
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
        
        
        let yelpURLFrame = CGRect(x: view.frame.midX+30, y: 300, width: 100, height: 80)
        let theURLView = UIButton(frame: yelpURLFrame)
        theURLView.setImage(UIImage(named:"yelpURL"), for: .normal)
        theURLView.addTarget(self, action: #selector(saveImage(_:)), for: .touchUpInside)
        view.addSubview(theURLView)

        let reviewButtonFrame = CGRect(x: view.frame.midX+100, y: 300, width: 100, height: 80)
        let theReviewButtonView = UIButton(frame: reviewButtonFrame)
        theReviewButtonView.setImage(UIImage(named:"reviewButton"), for: .normal)
        
        theReviewButtonView.addTarget(self, action: #selector(getReviews(_:)), for: .touchUpInside)

        view.addSubview(theReviewButtonView)

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
        view.addSubview(isClosedView)

        // Do any additional setup after loading the view.
    }
    

    let alert = UIAlertController(title: "OK", message: "There is no Yelp URL for this place", preferredStyle: .alert)
    
    @objc func saveImage(_ sender: UIButton) {

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

    @objc func getReviews(_ sender: UIButton) {
//        animatePresentContainer()
//        animateShowDimmedView()
//        setupConstraints()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
//        dimmedView.addGestureRecognizer(tapGesture)
        
        var reviewtext: String = ""
        var reviewid: String = ""
        
        sender.setImage(UIImage(named: "reviewButton2"), for: UIControl.State.normal)

        
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
            let thereviewframe = CGRect(x: view.frame.midX-150, y: view.frame.midY-150, width: 300, height: 400)
            let reviewText = UITextView(frame: thereviewframe)
            let reviewID = UITextView(frame: thereviewframe)
            reviewText.backgroundColor = UIColor.gray
            reviewID.backgroundColor = UIColor.gray
                    
         

            Foundation.URLSession.shared.dataTask(with: request) { (data, response, error) in
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
            print("4 \(reviewText.text)")
            view.addSubview(reviewText)
            view.addSubview(reviewID)
                        
    }
        
        
}
    
    
    
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
        // hide main container view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
                dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
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
    
    
//    @objc func getReviews() {
//        sender.setImage(UIImage(named: "reviewButton2"), for: UIControl.State.normal)
//    }

    
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
            
            // 5. Set static constraints
            NSLayoutConstraint.activate([
                // set dimmedView edges to superview
                dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                // set container static constraint (trailing & leading)
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
            
            // 6. Set container to default height
            containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
            // 7. Set bottom constant to 0
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
            // Activate constraints
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
