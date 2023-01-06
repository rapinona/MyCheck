//
//  SoloEmpleadoTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 23/11/22.
//

import UIKit

class SoloEmpleadoTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nombre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
