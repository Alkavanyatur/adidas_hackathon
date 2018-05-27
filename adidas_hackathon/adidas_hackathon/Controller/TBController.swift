//
//  TBController.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit
import SwipeableTabBarController


class TBController: SwipeableTabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func defaultTabBar() {
        selectedViewController = viewControllers?[1]
        //POR SI QUISIERAMOS CAMBIAR EL COLOR DEL TAB
        //tabBar.tintColor = UIColor(red: 117.0/255.0, green: 195.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        
        setSwipeAnimation(type: SwipeAnimationType.sideBySide)
        setTapAnimation(type: SwipeAnimationType.overlap)
        setDiagonalSwipe(enabled: true)
    }
    
}
