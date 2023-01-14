//
//  FormularioTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 03/12/22.
//

import UIKit

protocol FormularioTableViewCellDelegate : AnyObject{
    func didTapButton(with tag:Int)
}

class FormularioTableViewCell: UITableViewCell {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate : FormularioTableViewCellDelegate?
    
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
    
    @IBAction func deleteForm(_ sender: UIButton) {
        delegate?.didTapButton(with: sender.tag)
    }
    

}
