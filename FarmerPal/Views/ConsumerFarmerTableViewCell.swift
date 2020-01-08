//
//  ConsumerFarmerTableViewCell.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ConsumerFarmerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var farmerNameLabel: UILabel!
    @IBOutlet weak var milesDistanceLabel: UILabel!
    @IBOutlet weak var farmerPhotoImageView: UIImageView!
    @IBOutlet weak var viewFarmButton: UIButton!
    @IBOutlet weak var blueView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        blueView.layer.cornerRadius = 15
        farmerPhotoImageView.layer.cornerRadius = 10
        viewFarmButton.layer.cornerRadius = 15
    }
    
    @IBAction func viewFarmButtonPressed(_ sender: UIButton) {
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
