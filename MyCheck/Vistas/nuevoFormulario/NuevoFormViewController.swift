//
//  NuevoFormViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 03/12/22.
//

import UIKit

class NuevoFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var formulariosDM : FormulariosDataManager?
    var preguntas : [String] = []
    @IBOutlet var preguntasTable: UITableView!
    @IBOutlet var titulo: UITextField!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        preguntas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pregunta", for: indexPath) as! NuevoFormTableViewCell
        
        cell.pregunta.text = preguntas[indexPath.row]
        cell.deleteBtn.tag = indexPath.row
        
        cell.delegate = self
        
        return cell
    }
    
    @IBAction func nuevaPregunta(_ sender: Any) {
        let ac = UIAlertController(title: "Pregunta", message: nil, preferredStyle: .alert)
            ac.addTextField()

            let submitAction = UIAlertAction(title: "Agregar", style: .default) { [unowned ac] _ in
                let pregunta = ac.textFields![0].text
                if(pregunta != ""){
                    self.preguntas.append(pregunta!)
                    self.preguntasTable.reloadData()
                }
            }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive,handler: nil)

            ac.addAction(submitAction)
            ac.addAction(cancelAction)

            present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
        formulariosDM = FormulariosDataManager(context: self.context)

    }
    
    
    @IBAction func guardarForm(_ sender: Any) {
        if(self.preguntas.count == 0 || self.titulo.text == ""){
            let alert = UIAlertController(title: "My Team", message: "No completo el formulario", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)

        }else{
            let newForm = FormularioCD(context: self.context)
            
            newForm.formulario = self.titulo.text!
            
            do{
                try self.context.save()
            }
            catch{
                print("Error info: \(error)")
            }
            _ = navigationController?.popViewController(animated: true) 
        }
    }
    

}

extension NuevoFormViewController : NuevoFormTableViewCellDelegate{
    func didTapButton(with tag: Int) {
        self.preguntas.remove(at:tag)
        self.preguntasTable.reloadData()
    }
}
