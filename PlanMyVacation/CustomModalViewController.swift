//
//  CustomModalViewController.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 12/1/21.
//

import UIKit

class CustomModalViewController: UIViewController {
    var restaurants: Restaurants?
    var reviews: Reviews?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateShowDimmedView()
        animatePresentContainer()
    }
    //source: https://betterprogramming.pub/how-to-present-a-bottom-sheet-view-controller-in-ios-a5a3e2047af9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        //API Call
//        if let resId = restaurants?.id {
//            print("valid resid")
//            let apikey = "hWP1FMQbuRIU3Hvtt9_RMCJqFloDAhUoXyjw18nHWZJ9UrvAY9IOzU5zqZWN0FL3T8CtyXsNheVGCZT5ffZfD9ziVnvwKji0PnRX6na9ehtp8ev-kue9axtOYpCNYXYx"
//
//        let baseURL = "https://api.yelp.com/v3/businesses/\(resId)/reviews"
//
//        let url = URL(string: baseURL)
//        var request = URLRequest(url: url!)
//        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "GET"
//
//        Foundation.URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let err = error {
//                print(err.localizedDescription)
//                }
//                do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
//                print(">>>>>", json, #line, "<<<<<<<<<")
//                } catch {
//                print("caught")
//                }
//                }.resume()
//                }
        
        
        }

    
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
