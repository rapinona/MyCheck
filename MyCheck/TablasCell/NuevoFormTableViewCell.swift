//
//  NuevoFormTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 03/12/22.
//

import UIKit

protocol NuevoFormTableViewCellDelegate : AnyObject{
    func didTapButton(with tag:Int)
}

class NuevoFormTableViewCell: UITableViewCell {
    
    var delegate : NuevoFormTableViewCellDelegate?
    
    @IBOutlet var pregunta: UITextView!
    @IBOutlet var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    @IBAction func deletePregunta(_ sender: UIButton) {
        delegate?.didTapButton(with: sender.tag)
    }
    
}
