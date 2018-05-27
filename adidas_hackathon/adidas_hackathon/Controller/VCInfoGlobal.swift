//
//  VCInfoGlobal.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit

class VCInfoGlobal: UIViewController {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDesc.text = "This challenge is to walk for 20 days"
        lblTime.text = "2 days \n 23 hour \n 15 minutes"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
