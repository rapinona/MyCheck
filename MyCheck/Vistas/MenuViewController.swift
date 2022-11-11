//
//  MenuViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 11/10/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profilePicture.contentMode = UIView.ContentMode.scaleAspectFill
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height / 2
        self.profilePicture.layer.masksToBounds = false
        self.profilePicture.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
}
