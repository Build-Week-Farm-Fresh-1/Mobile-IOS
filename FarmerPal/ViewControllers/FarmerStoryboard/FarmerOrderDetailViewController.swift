//
//  FarmerOrderDetailViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FarmerOrderDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
