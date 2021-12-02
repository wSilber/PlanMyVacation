//
//  EditProfileViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//

import Foundation
import UIKit
class EditProfileViewController: UIViewController {
    
    /*
     *  saveBtnPressed: Action that dismisses the edit view controller and
     *                  saves the user's data when pressed
     */
    @IBAction func saveBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: save)
    }
    
    /*
     *  cancelBtnPressed: Action that dismisses the edit view controller and
     *                    does not save the user information
     */
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var citiesCount: UILabel!
    @IBOutlet weak var resterauntCount: UILabel!
    @IBOutlet weak var hotelsCount: UILabel!
    @IBOutlet weak var landmarksCount: UILabel!
    
    let profileController: ProfileController = ProfileController()
    var profileViewController: ProfileViewController?
    
    /*
     *  viewDidLoad: Instantiates profile controller and all UI components
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        profileController.getUserInfo()
        userNameInput.text = profileController.getUsername()
    }
    
    /*
     *  addProfileViewController: Adds a ProfileViewController to this view
     */
    func addProfileViewController(profileViewController: ProfileViewController) {
        self.profileViewController = profileViewController
    }
    
    /*
     *  save: Saves the user's info using the ProfileController. Reloads the
     *        user's profile page with the new data on success
     */
    func save() {
        print("Saving user data")
        guard let safeProfileViewController = profileViewController else { return }
        if let safeUsername = userNameInput.text {
            profileController.username = safeUsername
        }
        if(profileController.saveUserInfo()) {
            safeProfileViewController.reload()
        }
    }
}
