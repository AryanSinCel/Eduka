![Simulator Screen Recording - iPhone 16 Pro - 2025-01-16 at 13 47 12-min](https://github.com/user-attachments/assets/23a36efe-df40-4e32-8d64-53b2a80cd4c2)

# **Eduka**

## **Overview**

The **Eduka** is a feature-rich e-learning iOS application built using **Swift**. It allows users to learn and purchase and manage the courses. The app provides simple course management and event handling with CalenderKit and EventKit.

---

## **Features**

- **Add Events**: Add new events.  
- **Add Reminder**: Add the reminder to get notified.  
- **Purchase Course**: Ability to purchase courses.  
- **Track Progress**: Track Course Progress and covered topics.  
- **Search**: Search course by **title**.  
- **Profile Management**: Manage your profile (profile-image, and personal attributes).
- **Log In and Log Out**: Ability to login and logout.
- **Register**: Register yourself.
- **Notification**: Get Notification related to course.

---

## **Technologies Used**

- **Swift**: Core programming language for the app.  
- **UIKit**: For building the user interface.  
- **UserDefaults**: For local data persistence of todos and notes.
- **CoreData**: For storing the user data and courses associated with them.
- **MVVM Design Pattern**: Ensures clean code separation between the View, ViewModel, and Model.  

---

## **Architecture**

The app is structured using the **MVVM** (Model-View-ViewModel) design pattern:

1. **Model**:  
   Represents the data structure (e.g., `Course` model with `completion` and `progress` properties).  

2. **View**:  
   Handles UI components like `UITableView`, `UISearchBar`, and other visual elements.  

3. **ViewModel**:  
   Contains the app logic, such as managing todos, filtering data, and saving/loading to UserDefaults.  

---

## **How to Run the App**

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/Eduka.git
   ```

2. **Open in Xcode**:  
   - Open the project in **Xcode**.  

3. **Run on Simulator or Device**:  
   - Select a target device/simulator and press **Run** (`Cmd + R`).  

---

## **Future Enhancements**

- **Dark Mode**: Add support for dark mode.  
- **UI Inhancement**: Adding more interactivity.    
- **Categories**: Organize course into categories.
- **ScrollView**: Adding ScrollView to give freedom and more functionality.  

---

### **Enjoy managing your notes and tasks efficiently! 🚀**

---
