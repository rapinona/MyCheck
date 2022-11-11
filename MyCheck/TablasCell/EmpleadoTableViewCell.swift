//
//  EmpleadoTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import UIKit

class EmpleadoTableViewCell: UITableViewCell {

    
    @IBOutlet var NombreEmpleado: UILabel!
    @IBOutlet var TiendaEmpleado: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
