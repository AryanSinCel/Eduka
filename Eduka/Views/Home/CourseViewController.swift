//
//  CourseViewController.swift
//  Eduka
//
//  Created by Celestial on 03/01/25.
//

import UIKit

class CourseViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var courseContentView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var courseInstructorImageView: UIImageView!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var priceBtnLabel: UIButton!
    @IBOutlet weak var courseTitleLabel: UILabel!
    
    var courseContent: [String] = ["Basic Intro of Swift", "Functions and Methods", "Operators and Protocols", "Class and Structures", "Delegation"]
    var courseDuration: [String] = ["56 minutes", "1 hour", "2 hour", "3 hour", "1 hour"]
    var courseTitle: String?
    var coursePrice: String?
    
    var shared = AuthManager.shared
    
    @IBAction func buyCourse(_ sender: UIButton) {
        
        if shared.isSignIn{
            guard let courseTitle = courseTitle else { return }
            
            // Check if the course is already purchased
            if CourseManager.shared.getAllCourses().contains(courseTitle) {
                // Already purchased, update the button title
                buyBtn.setTitle("Purchased", for: .normal)
                buyBtn.isEnabled = false
            } else {
                // Add the course to the purchased list
                CourseManager.shared.addCourse(courseTitle)
                
                // Update the button to reflect purchase
                buyBtn.setTitle("Purchased", for: .normal)
                buyBtn.isEnabled = false
            }
        }else{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.loginVC) as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set course title and price if available
        if let title = courseTitle {
            courseTitleLabel.text = title
        }
        if let price = coursePrice {
            priceBtnLabel.setTitle(price, for: .normal)
        }
        
        // Style the Buy button
        buyBtn.backgroundColor = .red
        buyBtn.layer.cornerRadius = 10
        buyBtn.tintColor = .white
        
        // Style the instructor image view
        courseInstructorImageView.layer.cornerRadius = courseInstructorImageView.frame.width / 2
        courseInstructorImageView.clipsToBounds = true
        
        // Hide scroll indicators for the table view
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        // Configure the back button
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // Hide the review view initially
        reviewView.isHidden = true
        
        // Adjust the height of the segmented control
        let newHeight: CGFloat = 50
        var segmentFrame = segment.frame
        segmentFrame.size.height = newHeight
        segment.frame = segmentFrame
        
        // Check if the course is already purchased
        if let courseTitle = courseTitle, CourseManager.shared.getAllCourses().contains(courseTitle) {
            buyBtn.setTitle("Purchased", for: .normal)
            buyBtn.isEnabled = false
        }
    }

    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            courseContentView.isHidden = false
            reviewView.isHidden = true
        } else {
            courseContentView.isHidden = true
            reviewView.isHidden = false
        }
    }
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = courseContent[indexPath.row]
        cell.detailTextLabel?.text = courseDuration[indexPath.row]
        return cell
    }
}
