//
//  TabBarController.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 12/5/21.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var tabBarcontroll: UITabBar!
        override func viewDidLoad() {
        super.viewDidLoad()
            //print(tabBarcontroll?.items ?? "not sure here")

        // Do any additional setup after loading the view.
    }
//
//    func switchSearch(){
//        print("enter")
//        self.selectedIndex = 1
//    }
    var count: Int = 0
    func changeBadgeTrips(){
        //print(tabBarcontroll?.items[2] ?? "not sure")
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
