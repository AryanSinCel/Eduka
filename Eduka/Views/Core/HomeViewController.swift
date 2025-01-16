import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var courses: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        courses = ["All Course", "IOS", "Objective-C", "Development", "Android"]
        
        
        secondView.layer.cornerRadius = 20
        
        searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
        if let searchResultsVC = storyboard.instantiateViewController(withIdentifier: Constants.searchViewController) as? SearchViewController {
            navigationController?.pushViewController(searchResultsVC, animated: true)
        } else {
            print("Error: Could not find SearchViewController in storyboard.")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

