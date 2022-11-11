//
//  MisFormulariosViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 23/09/22.
//

import UIKit
import TabPageViewController

class MisFormulariosViewController: UIViewController {

    let tc = LimitedTabPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.pushViewController(tc, animated: true)
        // Do any additional setup after loading the view.
    }
    
}
