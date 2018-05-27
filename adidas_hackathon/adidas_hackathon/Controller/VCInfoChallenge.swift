//
//  VCInfoChallenge.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit
import FirebaseAuth

class VCInfoChallenge: UIViewController {
    
    
    var dicAll:[NSMutableDictionary] = []
    var dicInfo:NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func activateChallenge(){
        for dic in dicAll {
            if dic["key"] as! String == dicInfo["key"] as! String{
                dic["mode"] = "enable"
            }else{
                dic["mode"] = "disable"
            }
        }
        let uid = Auth.auth().currentUser?.uid
        Dataholder.sharedInstance.firDataBaseRef.child("Users").child(uid!).child("Challenge").setValue(dicAll)
        print("PUSHED")
    }
    
}
