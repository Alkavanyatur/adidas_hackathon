//
//  vcSelectPreferences.swift
//  HackatonAdidas
//
//  Created by Charly Maxter on 27/5/18.
//  Copyright © 2018 HackatonAdidas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VCSelectPreferences: UIViewController {
    
    var preferences:[String:Bool] = ["hiking":false, "bike":false, "run":false, "walk":false, "swimming":false]
    
    @IBOutlet weak var btnHiking:UIButton!
    @IBOutlet weak var btnBike:UIButton!
    @IBOutlet weak var btnRun:UIButton!
    @IBOutlet weak var btnWalk:UIButton!
    @IBOutlet weak var btnSwim:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedImage(_ sender: UIButton){
        if sender == btnRun {
            changeDataDictionary("run")
        }else if sender == btnBike{
            changeDataDictionary("bike")
        }else if sender == btnSwim{
            changeDataDictionary("swimming")
        }else if sender == btnWalk{
            changeDataDictionary("walk")
        }else if sender == btnHiking{
            changeDataDictionary("hiking")
        }
    }
    
    func changeDataDictionary(_ preference:String){
        if preferences[preference]! {
            preferences[preference] = false
        }else{
            preferences[preference] = true
        }
    }
    
    @IBAction func next(){
        let uid = Auth.auth().currentUser?.uid
        Dataholder.sharedInstance.firDataBaseRef.child("Users").child(uid!).child("preferences").setValue(preferences)
        performSegue(withIdentifier: "trSelectToTabBar", sender: self)
    }
    
}
