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
    
    @IBOutlet weak var imgTop:UIImageView!
    @IBOutlet weak var lblChallenge: UILabel!
    @IBOutlet weak var viewProgress: ViewProgressBar!
    
    var dicAll:[NSMutableDictionary] = []
    var dicInfo:NSDictionary = [:]
    
    var txt:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        let typeSport = dicInfo["typeSport"] as! String
        
        switch typeSport {
        case "walk":
            imgTop.image = #imageLiteral(resourceName: "challenge_walk")
            break
        case "swimming":
            imgTop.image = #imageLiteral(resourceName: "challenge_swimming")
            break
        case "run":
            imgTop.image = #imageLiteral(resourceName: "challenge_running")
            break
        case "hiking":
            imgTop.image = #imageLiteral(resourceName: "challenge_hiking")
            break
        case "bike":
            imgTop.image = #imageLiteral(resourceName: "challenge-bike")
            break
        default:
            imgTop.image = #imageLiteral(resourceName: "challenge_walk")
            
        }
        
        let mode = dicInfo["mode"] as! String
        if mode == "enable" {
            viewProgress.progress = 0.7
        }else{
            viewProgress.progress = 0
        }
        lblChallenge.text = txt
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
