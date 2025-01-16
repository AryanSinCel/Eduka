import UIKit

class ProgramsViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var inProgressCourses: [(courseName: String, progress: Double)] = []
    var completedCourses: [String] = []
    
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 20

        let newHeight: CGFloat = 50
        var segmentFrame = segment.frame
        segmentFrame.size.height = newHeight
        segment.frame = segmentFrame
        
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadCourses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          loadCourses() 
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showDetail {
            let vc = segue.destination as! CourseDetailedVC
            if segment.selectedSegmentIndex == 0 {
                let course = inProgressCourses[selectedIndex]
                vc.courseTitle = course.courseName
                vc.courseProgress = course.progress
            } else {
                let courseName = completedCourses[selectedIndex]
                vc.courseTitle = courseName
                vc.courseProgress = 1.0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: Constants.showDetail, sender: self)
    }
    
    func loadCourses() {
        let allCourses = CourseManager.shared.purchasedCourses
        
        inProgressCourses = allCourses.filter { !$0.value.completion }.map { ($0.key, $0.value.progress) }
        completedCourses = allCourses.filter { $0.value.completion }.map { $0.key }
        
        tableView.reloadData()
    }
    
    @objc func segmentChanged() {
        tableView.reloadData()
    }
}

extension ProgramsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return inProgressCourses.count
        } else {
            return completedCourses.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ProgressTableViewCell
        
        if segment.selectedSegmentIndex == 0 {
            let course = inProgressCourses[indexPath.row]
            cell.courseTitle.text = course.courseName
            cell.courseProgress.text = "\(Int(course.progress * 100))% Completed"
            cell.progressBar.isHidden = false
            cell.progressBar.progress = Float(course.progress)
        } else {
            let courseName = completedCourses[indexPath.row]
            cell.courseTitle.text = courseName
            cell.courseProgress.text = "100% Completed"
            cell.progressBar.isHidden = true
        }
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 15
        cell.backgroundColor = .systemMint
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(
            x: cell.bounds.origin.x,
            y: cell.bounds.origin.y,
            width: cell.bounds.width,
            height: cell.bounds.height
        ).insetBy(dx: 0, dy: verticalPadding / 2)
        cell.layer.mask = maskLayer
    }
}
