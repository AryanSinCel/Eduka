//
//  SearchViewController.swift
//  Eduka
//
//  Created by Celestial on 10/01/25.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // Example data source for the table view
    var courses: [String] = ["iOS Development", "Android Development", "Web Development", "Data Science", "Machine Learning", "Cloud Computing", "Cyber Security", "Blockchain", "UI/UX Design", "Game Development"]
    var imageData: [String] = ["learn-swift", "learn-swift", "learn-swift", "learn-swift", "learn-swift", "learn-swift", "learn-swift", "learn-swift", "learn-swift", "learn-swift"]
    var prices: [String] = ["$50","$30","$20","$100","$200","$150","$50","$99","$40","$50"]
    var selectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.showsVerticalScrollIndicator = false
//        tableView.showsHorizontalScrollIndicator = false
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black

        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        navigationItem.hidesBackButton = false
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! CourseSearchViewCell
        cell.courseTitle?.text = courses[indexPath.row] // Example: Set course name
        cell.courseImage.image = UIImage(named: imageData[indexPath.row])
        cell.priceLabel.text = prices[indexPath.row]
        cell.priceLabel.backgroundColor = .red
        cell.priceLabel.layer.masksToBounds = true
        cell.priceLabel.layer.cornerRadius = 10
        cell.priceLabel.textColor = .white
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showSearchedCourse{
            let vc = segue.destination as! CourseViewController
            vc.courseTitle = courses[selectedIndex]
            vc.coursePrice = prices[selectedIndex]
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            courses = ["iOS Development", "Android Development", "Web Development", "Data Science", "Machine Learning", "Cloud Computing", "Cyber Security", "Blockchain", "UI/UX Design", "Game Development"]
        } else {
            courses = courses.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: Constants.showSearchedCourse, sender: self)
    }
    
}
