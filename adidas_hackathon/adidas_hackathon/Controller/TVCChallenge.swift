//
//  TVCchallenge.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit

class TVCChallenge: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var lblCellTitle: UILabel!
    @IBOutlet weak var lblHeart: UILabel!
    @IBOutlet weak var lblEnergy: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "cell_challenge")
        imageCell = backgroundImage
        lblCellTitle.text = ""
        lblHeart.text = ""
        lblEnergy.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
