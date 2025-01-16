//
//  OngoingCollectionView.swift
//  Eduka
//
//  Created by Celestial on 02/01/25.
//

import UIKit


class OngoingCollectionView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    var ongoingCourses:[String] = ["Android","IOS","Web Development"]
    var courseProgress:[Float] = [0.5,0.4,0.3]
    var courseProgLabel:[String] = ["10 lesson","20 lesson","5 lesson"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ongoingCourses.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! OngoingCourseCell
         cell.titleLabel.text = ongoingCourses[indexPath.row]
         cell.progressLabel.text = courseProgLabel[indexPath.row]
         cell.progressBar.setProgress(courseProgress[indexPath.row], animated: true)
         cell.layer.cornerRadius = 15
    
        return cell
    }
}
