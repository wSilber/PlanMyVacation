//
//  ProfileViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    /*
     *  editBtn: Action that displays the EditProfileController to the user
     *           so they can input new data to edit their account
     */
    @IBAction func editBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let editProfileController = storyBoard.instantiateViewController(identifier: "EditProfileController") as! EditProfileViewController
        
        editProfileController.addProfileViewController(profileViewController: self)
        
        self.present(editProfileController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var citiesCount: UILabel!
    @IBOutlet weak var ResterauntsCount: UILabel!
    @IBOutlet weak var hotelsCount: UILabel!
    @IBOutlet weak var landMarksCount: UILabel!
    
    let profileController: ProfileController = ProfileController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileController.getUserInfo()
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reload()
    }
    
    /*
     *  reload: Reloads all UI Components (CURRENTLY ONLY RELOADS USERNAME)
     *  TODO: RELOAD ALL COMPONENTS
     */
    func reload() {
        profileController.getUserInfo()
        if let username = profileController.getUsername() {
            usernameLabel.text = username
        }
        
        if let cities = profileController.cityCount {
            citiesCount.text = String(cities)
        }
        
        if let resteraunts = profileController.resterauntCount {
            ResterauntsCount.text = String(resteraunts)
        }
        
        if let hotels = profileController.hotelCount {
            hotelsCount.text = String(hotels)
        }
        
        if let landmarks = profileController.landmarkCount {
            landMarksCount.text = String(landmarks)
        }
        
        if let profilePicture = profileController.profilePicture {
            profilePictureView.image = profilePicture
        }

    }
    
}
