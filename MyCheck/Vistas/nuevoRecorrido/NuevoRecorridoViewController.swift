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
    let tiendasDM = TiendaDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.selectedIndex=1
        
        self.tiendasDM.fetch(){
            DispatchQueue.main.async {
                self.dropdownRecorrido.optionArray = self.tiendasDM.todasTiendasNombre()
                //Its Id Values and its optional
                self.dropdownRecorrido.optionIds = self.tiendasDM.todasTiendasID()
            }
        }

        dropdownRecorrido.selectedRowColor = UIColor(red: 0.45, green: 0.95, blue: 0.44, alpha: 1.00)
        dropdownRecorrido.checkMarkEnabled = false

        // Do any additional setup after loading the view.

        
    }
    
}
