//
//  VCLogin.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 26/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VCLogin: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var lblPass: UILabel!
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var viewRoot: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VCLogin.dismissKeyboard))
        
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
    
    
    func loginF(email: String, pass: String){
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error == nil {
                self.avanzar()
            } else {
                //TODO NOTIFICAR ERROR
            }
        }
 
    }
    
    func avanzar(){
        self.performSegue(withIdentifier: "trLoginToSelect", sender: self)
    }
    
    func  setupView() {
        //backgroundImage
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "main")
        backgroundImage.alpha = 0.80
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        viewRoot.insertSubview(backgroundImage, at: 0)
        //
        btnLogin.backgroundColor = .clear
        btnLogin.layer.cornerRadius = btnLogin.frame.height / 2
        btnLogin.layer.borderColor = UIColor.white.cgColor
        btnLogin.layer.borderWidth = 1
        btnLogin.clipsToBounds = true
        btnLogin.tintColor = UIColor.white
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        if let username = txtUsername.text, let pass = txtPass.text {
            loginF(email: username, pass: pass)
        }else{
            print("no hay datos")
        }
    }
    
    @IBAction func actionSignIn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "trLoginToSignin", sender: self)

    }
    
}
