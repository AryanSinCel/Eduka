import UIKit

class CourseDetailedVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var lessonContentView: UIView!
    @IBOutlet weak var courseDetailView: UIView!
    @IBOutlet weak var instructorProfileImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var placeHolderImage: UIImageView!
    var courseTitle: String?
    var courseProgress: Double = 0.0
    
    var courseContent: [String] = ["Basic Intro of Swift", "Functions and Methods", "Operators and Protocols", "Class and Structures", "Delegation"]
    var courseDuration: [String] = ["56 minutes", "1 hour", "2 hour", "3 hour", "1 hour"]
    
    var selectedRows: Set<IndexPath> = [] // To track selected rows
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var readBtn: UIButton!
    @IBOutlet weak var briefOverview: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func expandReadMode(_ sender: UIButton) {
        if briefOverview.numberOfLines == 4{
            readBtn.setTitle("read more", for: .normal)
            briefOverview.numberOfLines = 2
        }else{
            readBtn.setTitle("read less", for: .normal)
            briefOverview.numberOfLines = 4
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        guard let courseTitle = courseTitle else { return }
        
        courseProgress = CourseManager.shared.getProgress(for: courseTitle) ?? 0.0
        
        webView.scrollView.isScrollEnabled = false
        
        webView.loadHTMLString("""
            <iframe width="\(webView.frame.width)" height="\(webView.frame.height)" 
            src="https://www.youtube.com/embed/8Xg7E9shq0U" 
            title="Swift Programming Tutorial – Full Course for Beginners" 
            frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
            referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
        """, baseURL: nil)
        
        courseDetailView.isHidden = false
        lessonContentView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tintColor = .black
        tableView.isEditing = true
        tableView.allowsMultipleSelectionDuringEditing = true
        
        // Check progress and select cells based on progress
        let totalLessons = courseContent.count
        let completedLessons = Int(Double(totalLessons) * courseProgress)
        for i in 0..<completedLessons {
            let indexPath = IndexPath(row: i, section: 0)
            selectedRows.insert(indexPath)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
        instructorProfileImage.layer.cornerRadius = instructorProfileImage.frame.width / 2
        imageView.layer.cornerRadius = 20
        playBtn.backgroundColor = .systemMint
        playBtn.layer.cornerRadius = playBtn.frame.width / 2
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let newHeight: CGFloat = 50
        var segmentFrame = segment.frame
        segmentFrame.size.height = newHeight
        segment.frame = segmentFrame
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            courseDetailView.isHidden = false
            lessonContentView.isHidden = true
        } else {
            courseDetailView.isHidden = true
            lessonContentView.isHidden = false
        }
    }
    
    private func updateCourseProgress() {
        guard let courseTitle = courseTitle else { return }
        
        // Calculate progress
        let progress = Double(selectedRows.count) / Double(courseContent.count)
        CourseManager.shared.updateProgress(for: courseTitle, progress: progress)
        
        // Check if course is completed
        if progress == 1.0 {
            print("Course \(courseTitle) completed!")
        }
    }
}

extension CourseDetailedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        cell?.textLabel?.text = courseContent[indexPath.row]
        cell?.detailTextLabel?.text = courseDuration[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRows.insert(indexPath)
        updateCourseProgress()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedRows.remove(indexPath)
        updateCourseProgress()
    }
}

extension CourseDetailedVC: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        placeHolderImage.isHidden = false
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        placeHolderImage.isHidden = true
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Failed to load video: \(error.localizedDescription)")
    }
}
