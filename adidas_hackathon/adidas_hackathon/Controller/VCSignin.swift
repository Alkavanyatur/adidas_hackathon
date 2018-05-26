//
//  VCSignin.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 26/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit

class VCSignin: UIViewController {

    @IBOutlet weak var viewRoot: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VCSignin.dismissKeyboard))
        
        //Uncomment, if the tap should not interfere or cancel other actions
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //The views and the entire hierarchy resignation to respond, to hide the keyboard
        view.endEditing(true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    
    func  setupView() {
        //backgroundImage
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "register")
        backgroundImage.alpha = 0.80
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        viewRoot.insertSubview(backgroundImage, at: 0)
    }

}
