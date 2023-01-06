//
//  FormularioTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 03/12/22.
//

import UIKit

class FormularioTableViewCell: UITableViewCell {

    
    @IBOutlet var nombreForm: UILabel!
    @IBOutlet var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
