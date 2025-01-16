//
//  CustomTabBarVC.swift
//  Eduka
//
//  Created by Celestial on 02/01/25.
//

import UIKit

class CustomTabBarVC: UITabBarController , UITabBarControllerDelegate{

    var tabB: TabBarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.selectedIndex = 0
        
        if let customTabBar = self.tabBar as? TabBarView {
                    tabB = customTabBar
        }
        
        var swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)

        swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)

    }
    
    @objc private func swipeGesture(swipe: UISwipeGestureRecognizer){
        switch swipe.direction{
        case .left:
            self.selectedIndex = self.selectedIndex + 1
            tabB?.updateCurveForTappedIndex()
            break
        case .right:
            self.selectedIndex = self.selectedIndex - 1
            tabB?.updateCurveForTappedIndex()
            break
        default:
            break
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tabBar = tabBar as? TabBarView{
            tabB = tabBar
            tabBar.updateCurveForTappedIndex()
        }
    }

}
