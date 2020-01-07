//
//  ConsumerHomeViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

//Intern == Follows orders -> You have to conform to a delegate(to recieve info)
class ConsumerHomeViewController: UIViewController {
    
    var user: User?
//    let controller = Controller()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        navigationController?.setNavigationBarHidden(true, animated: true)
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
