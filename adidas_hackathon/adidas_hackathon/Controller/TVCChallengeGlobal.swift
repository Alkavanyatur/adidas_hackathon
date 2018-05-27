//
//  TVCChallengeGlobal.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit

class TVCChallengeGlobal: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var lblTimeLeft: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "cell_special_challenge")
        imageCell = backgroundImage
        lblTimeLeft.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
