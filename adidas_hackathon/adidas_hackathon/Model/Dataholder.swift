//
//  Dataholder.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Dataholder: NSObject {
    
    static let sharedInstance:Dataholder=Dataholder()
    
    //Constants
    let GET_URL = "http://34.253.229.234:3000/"
    
    var healthAvailable: Bool = false
    
    var firDataBaseRef:DatabaseReference!
    
    func initFirebase(){
        FirebaseApp.configure()
        firDataBaseRef=Database.database().reference()
    }
}
