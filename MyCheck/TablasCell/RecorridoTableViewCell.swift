//
//  RecorridoTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import UIKit

class RecorridoTableViewCell: UITableViewCell {

    
    @IBOutlet var nombre: UILabel!
    @IBOutlet var tienda: UILabel!
    @IBOutlet var fecha_fin: UILabel!
    @IBOutlet var delete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
