//
//  VerMasFotoViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 05/11/22.
//

import UIKit

class VerMasFotoViewController: UIViewController {
    
    
    var currentFoto : UIImage?
    
    @IBOutlet var foto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foto.image = currentFoto
        // Do any additional setup after loading the view.
    }

}
