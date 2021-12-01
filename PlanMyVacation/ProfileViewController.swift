//
//  ProfileViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    @IBAction func editBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let editProfileController = storyboard?.instantiateViewController(identifier: "EditProfileController") as! EditViewController
        
        self.present(editProfileController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
