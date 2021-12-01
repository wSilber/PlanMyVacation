//
//  EditProfileViewController.swift
//  PlanMyVacation
//
//  Created by William Silberstein on 12/1/21.
//

import Foundation
import UIKit
class EditProfileViewController: UIViewController {
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: save)
    }
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getUserInfo() {
        
    }
    
    func saveUserInfo() {
        
    }
    
    func save() {
        
    }
    
    func getUserImage() {
        
    }
    
}
