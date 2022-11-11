//
//  NuevoRecorridoViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import UIKit
import iOSDropDown

class NuevoRecorridoViewController: UIViewController {
    
    
    @IBOutlet weak var dropdownRecorrido: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.selectedIndex=1
        
        // The list of array to display. Can be changed dynamically
        dropdownRecorrido.optionArray = ["Option 1", "Option 2", "Option 3"]
        //Its Id Values and its optional
        dropdownRecorrido.optionIds = [1,23,54]
        dropdownRecorrido.selectedRowColor = UIColor(red: 0.45, green: 0.95, blue: 0.44, alpha: 1.00)
        dropdownRecorrido.checkMarkEnabled = false

        // Do any additional setup after loading the view.

        
    }
    
}
