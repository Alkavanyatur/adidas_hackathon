//
//  ViewController.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 26/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit

class Splash: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "trSplashToLogin", sender: self)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

