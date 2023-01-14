//
//  RecorridoTableViewCell.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import UIKit

protocol RecorridoTableViewCellDelegate : AnyObject{
    func didTapButton(with tag:Int)
    func didEditButton(with tag:Int)
}

class RecorridoTableViewCell: UITableViewCell {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate : RecorridoTableViewCellDelegate?
    
    @IBOutlet var nombre: UILabel!
    @IBOutlet var tienda: UILabel!
    @IBOutlet var fecha_fin: UILabel!
    @IBOutlet var delete: UIButton!
    @IBOutlet var edit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editRecorrido(_ sender: UIButton) {
        delegate?.didEditButton(with: sender.tag)
    }
    
    @IBAction func deleteRecorrido(_ sender: UIButton) {
        delegate?.didTapButton(with: sender.tag)
    }

}
