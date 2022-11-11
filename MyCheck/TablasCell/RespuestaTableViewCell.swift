//
//  RespuestaTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 10/09/22.
//

import UIKit

class RespuestaTableViewCell: UITableViewCell {

    @IBOutlet var pregunta: UILabel!
    @IBOutlet var categoria: UILabel!
    @IBOutlet var delete: UIButton!
    @IBOutlet var rechazo: UIView!
    @IBOutlet var aceptar: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
