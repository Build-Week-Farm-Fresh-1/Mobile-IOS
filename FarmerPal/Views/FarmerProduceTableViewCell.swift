//
//  FarmerProduceTableViewCell.swift
//  FarmerPal
//
//  Created by macbook on 1/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FarmerProduceTableViewCell: UITableViewCell {
    
    var produce: Produce? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateViews() {
        
        guard let produce = produce,
            let image = produce.produceImgURL,
            let imageURL = URL(string: image) else { return }
        
        do {
            nameLabel.text = produce.name
            let imageData = try Data(contentsOf: imageURL)
            photoImageView.image = UIImage(data: imageData)
            photoImageView.layer.cornerRadius = 15
            
        } catch {
            photoImageView.layer.cornerRadius = 15
            nameLabel.text = produce.name
        }
    }
}
