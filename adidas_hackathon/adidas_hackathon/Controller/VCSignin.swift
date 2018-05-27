//
//  VCSignin.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 26/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VCSignin: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var lblPass: UILabel!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var viewRoot: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    @IBAction func actionRegister(_ sender: UIButton) {
        if let username = txtUsername.text, let pass = txtPass.text, let email = txtEmail.text{
                registroF(email: email, pass: pass)
        }else{
            print("no hay datos")
        }
    }
    
    func registroF(email:String, pass:String){
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error == nil {
                //Dataholder.sharedInstance.firDataBaseRef.child("Usuarios").child((user?.uid)!).setValue("HOLA")
                print("REGISTRADO!")
                self.avanzar()
            }else{
                //print(error)
            }
        }
        
    }
    
    func avanzar(){
        self.performSegue(withIdentifier: "trSigninToSelect", sender: self)
    }

}
