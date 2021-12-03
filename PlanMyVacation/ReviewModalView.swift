//
//  ReviewModalView.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 12/2/21.
//

import UIKit

class ReviewModalView: UIViewController {
    var reviewsModal: [Reviews] = []

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Recent Reviews"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        if(reviewsModal.count >= 1) {
        label.text = ("User ID " + (reviewsModal[0].id ?? "No User Id")) + (": " + (reviewsModal[0].text ?? "No Review"))
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.numberOfLines = 5
        }
        return label
    }()
    lazy var notesLabel2: UILabel = {
        let label2 = UILabel()
        if(reviewsModal.count >= 2){
        label2.text = ("User ID " + (reviewsModal[1].id ?? "No User Id")) + (": " + (reviewsModal[1].text ?? "No Review"))
        label2.font = .systemFont(ofSize: 13)
        label2.textColor = .darkGray
        label2.numberOfLines = 5
        }
        return label2
    }()
    lazy var notesLabel3: UILabel = {
        let label3 = UILabel()
        if(reviewsModal.count >= 3){
        label3.text = ("User ID " + (reviewsModal[2].id ?? "No User Id")) + (": " + (reviewsModal[2].text ?? "No Review"))
        label3.font = .systemFont(ofSize: 13)
        label3.textColor = .darkGray
        label3.numberOfLines = 5
        }
        return label3
    }()
    lazy var additionalLabel: UILabel = {
        let label4 = UILabel()
        label4.text = ("For more information on reviews, please click the Yelp button")
        label4.font = .systemFont(ofSize: 15)
        label4.textColor = UIColor.black
        label4.numberOfLines = 5
        return label4
    }()
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, notesLabel,notesLabel2,notesLabel3, spacer, additionalLabel,spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
//        stackView.backgroundColor = UIColor(red: 69, green: 179, blue: 124, alpha: 0.5)
        return stackView
    }()
    
    
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
        
        let defaultHeight: CGFloat = 500
    
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
        print("reviewmodalview \(reviewsModal)")
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
        // Add subviews
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content stackView
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
