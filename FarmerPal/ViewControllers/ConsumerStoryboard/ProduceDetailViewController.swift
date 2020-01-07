//
//  ProduceDetailViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ProduceDetailViewController: UIViewController {
    
    var user: User?
    var produce: Produce?
    
    @IBOutlet weak var produceNameLabel: UILabel!
    @IBOutlet weak var farmerNameLabel: UILabel!
    @IBOutlet weak var produceDescriptionLabel: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var addToCartButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
        
        addToCartButton.titleLabel?.text = "✅"
    }
    
    func updateViews() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        guard let produce = produce,
            let name = produce.name,
            let farmerName = produce.farmerName,
            let image = produce.image,
            let description = produce.produceDescription else { return }
      
//        let imageURL = URL(string: image)
//        let imageData = Data(imageURL)
        
        produceNameLabel.text = name
        farmerNameLabel.text = farmerName
        produceDescriptionLabel.text = description
        
        // TODO: Setup producte image display
        
//        photoImageView.image = UIImage(data: imageData)
    }
}
