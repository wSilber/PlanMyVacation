//
//  ExplorePage.swift
//  PlanMyVacation
//
//  Created by Simran Ajwani on 11/27/21.
//

import UIKit

class Explore: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var cityName: UILabel!
    var timer = Timer()
    var counter = 0
    var imgArr = [ UIImage(named: "image1"),
                   UIImage(named: "image2"),
                   UIImage(named: "image3"),
                   UIImage(named: "image4"),
                   UIImage(named: "image5"),
                   UIImage(named: "image6"),
                   UIImage(named: "image7"),
                   UIImage(named: "image8"),
                   UIImage(named: "image9"),
                   UIImage(named: "image10")
    ]
    var text = ["San Francisco", "Las Vegas", "St. Louis", "Manhattan", "Denver", "Flagstaff", "Salt Lake City", "Detroit", "Seattle", "Miami"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    ////citation: https://www.youtube.com/watch?v=cbeE3OQlU3c
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        return cell
    }
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!

    ////citation: https://www.youtube.com/watch?v=cbeE3OQlU3c
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.text = "Explore San Francisco"
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        pageController.numberOfPages = imgArr.count
        pageController.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //citation: https://www.youtube.com/watch?v=cbeE3OQlU3c
    @objc func changeImage() {
     if counter < imgArr.count {
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageController.currentPage = counter
        cityName.text = "Explore " + text[counter]
        counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageController.currentPage = counter
        cityName.text = "Explore " + text[counter]
         counter = 1
     }
         
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

extension Explore: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
