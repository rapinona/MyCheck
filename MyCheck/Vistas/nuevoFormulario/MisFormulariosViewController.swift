//
//  MisFormulariosViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 23/09/22.
//

import UIKit

class MisFormulariosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var formulariosDM : FormulariosDataManager?
    var currentFormulario : FormularioCD?
    var formularios : [FormularioCD]?
    @IBOutlet var FormulariosTable: UITableView!
    @IBOutlet var newForm: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formulariosDM?.formularioCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "formulario", for: indexPath) as! FormularioTableViewCell
        
        let formulario : FormularioCD?
        
        formulario = formulariosDM?.formularioAt(index: indexPath.row)
        
        cell.nombreForm.text = formulario?.formulario
        cell.deleteBtn.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    
    @IBAction func nuevoForm(_ sender: Any) {
        self.performSegue(withIdentifier: "nuevaPregunta", sender: Self.self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formulariosDM = FormulariosDataManager(context: self.context)
        self.formulariosDM?.fetchCD()
        self.formularios = self.formulariosDM?.todosFormularios()
        self.FormulariosTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.formulariosDM?.fetchCD()
        self.FormulariosTable.reloadData()
    }
    
}

extension MisFormulariosViewController : FormularioTableViewCellDelegate{
    func didTapButton(with tag: Int) {

        currentFormulario = formulariosDM!.formularioAt(index: tag)
        let formularioToRemove = currentFormulario!
        self.context.delete(formularioToRemove)
        do{
            try self.context.save()
            formulariosDM = FormulariosDataManager(context: self.context)
        }catch{
                
        }
        self.formulariosDM?.fetchCD()
        self.FormulariosTable.reloadData()

    }
}
