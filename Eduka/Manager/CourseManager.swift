import Foundation

class CourseManager {
    static let shared = CourseManager()

    private let userDefaultsKey = Constants.userDefaultKey
    private(set) var purchasedCourses: [String: CourseProgress] = [:]

    private init() {
        loadCoursesFromUserDefaults()
    }

    func addCourse(_ courseName: String) {
        if purchasedCourses[courseName] == nil {
            purchasedCourses[courseName] = CourseProgress(completion: false, progress: 0.0)
            saveCoursesToUserDefaults()
        }
    }

    func updateProgress(for courseName: String, progress: Double) {
        guard var course = purchasedCourses[courseName] else { return }
        course.progress = progress
        if progress >= 1.0 {
            course.completion = true
        }
        purchasedCourses[courseName] = course
        saveCoursesToUserDefaults()
    }

    func getProgress(for courseName: String) -> Double? {
        return purchasedCourses[courseName]?.progress
    }

    func isCompleted(courseName: String) -> Bool {
        return purchasedCourses[courseName]?.completion ?? false
    }

    func getAllCourses() -> [String] {
        return Array(purchasedCourses.keys)
    }

    private func saveCoursesToUserDefaults() {
        var storageData: [String: [String: Any]] = [:]
        for (key, value) in purchasedCourses {
            storageData[key] = [
                "completion": value.completion,
                "progress": value.progress
            ]
        }
        UserDefaults.standard.set(storageData, forKey: userDefaultsKey)
    }

    private func loadCoursesFromUserDefaults() {
        guard let savedData = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: [String: Any]] else { return }
        var loadedCourses: [String: CourseProgress] = [:]
        for (key, value) in savedData {
            if let completion = value["completion"] as? Bool,
               let progress = value["progress"] as? Double {
                loadedCourses[key] = CourseProgress(completion: completion, progress: progress)
            }
        }
        purchasedCourses = loadedCourses
    }
}


