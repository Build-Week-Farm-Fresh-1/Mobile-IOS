//
//  FarmerProduceTableViewCell.swift
//  FarmerPal
//
//  Created by macbook on 1/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FarmerProduceTableViewCell: UITableViewCell {
    
    var produce: Produce?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.layer.cornerRadius = 15
    }
    
    func updateViews() {
        
        guard let produce = produce else { return }
        
        nameLabel.text = produce.name
//        photoImageView.image = produce.image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
