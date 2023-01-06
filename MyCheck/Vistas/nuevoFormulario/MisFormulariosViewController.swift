//
//  MisFormulariosViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 23/09/22.
//

import UIKit

class MisFormulariosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nuevo : Formulario? = nil
    let formulariosDM = FormulariosDataManager()
    var currentFormulario : Formulario?
    var formularios : [Formulario]?
    @IBOutlet var FormulariosTable: UITableView!
    @IBOutlet var newForm: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formulariosDM.formularioCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "formulario", for: indexPath) as! FormularioTableViewCell
        
        let formulario : Formulario?
        
        formulario = formulariosDM.formularioAt(index: indexPath.row)
        
        cell.nombreForm.text = formulario?.Formulario
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NuevoFormViewController
        destination.anteriores = self.formularios
    }
    
    
    @IBAction func nuevoForm(_ sender: Any) {
        self.performSegue(withIdentifier: "nuevaPregunta", sender: Self.self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if((self.nuevo) != nil){
            self.formularios?.append(nuevo!)
            self.formulariosDM.fetch(anteriores:self.formularios ?? []){
                DispatchQueue.main.async {
                    self.formularios = self.formulariosDM.todosFormularios()
                    self.FormulariosTable.reloadData()
                }
            }
        }else{
            self.formulariosDM.fetch(anteriores:[]){
                DispatchQueue.main.async {
                    self.formularios = self.formulariosDM.todosFormularios()
                    self.FormulariosTable.reloadData()
                }
            }
        }
    }
    
}
