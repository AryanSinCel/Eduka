//
//  CourseCollectionView.swift
//  Eduka
//
//  Created by Celestial on 02/01/25.
//

import UIKit


class CourseCollectionView: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var courseTitle:[String] = []
    var coursePrice:[String] = []
    
    var selectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        courseTitle = ["IOS","Android","Javascript","Web Dev","Swift UI","Swift","Figma","Game Development"]
        coursePrice = ["$50","$30","$20","$100","$200","$150","$50","$99"]

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! CourseCell
        cell.imageView.image = UIImage(named: "learn-swift")
        cell.courseTitle.text = courseTitle[indexPath.row]
        cell.coursePrice.text = coursePrice[indexPath.row]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 15
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showCourse{
            let vc = segue.destination as! CourseViewController
            vc.courseTitle = courseTitle[selectedIndex]
            vc.coursePrice = coursePrice[selectedIndex]
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: Constants.showCourse, sender: self)
    }
    

}

extension CourseCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth / 2 - 20, height: collectionWidth / 2)
    }
}
