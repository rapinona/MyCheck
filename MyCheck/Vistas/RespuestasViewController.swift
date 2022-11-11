//
//  EstatusViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 07/09/22.
//

import UIKit

class RespuestasViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate{
    
    let respuestasDM = RespuestaDataManager()
    var selectedRespuesta: Int = 0
    var currentRecorrido = 0
    var currentEmpleado = 0
    
    @IBOutlet var RespuestaTable: UITableView!
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        respuestasDM.respuestasCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "respuesta", for: indexPath) as! RespuestaTableViewCell
        
        let respuesta = respuestasDM.respuestaAt(index: indexPath.row)
        
        cell.pregunta.text = respuesta.pregunta
        cell.categoria.text = respuesta.categoria
        
        if(respuesta.cumple == "No Cumple"){
            cell.aceptar.isHidden = true
            cell.rechazo.isHidden = false
        }else if(respuesta.cumple == "Cumple"){
            cell.aceptar.isHidden = false
            cell.rechazo.isHidden = true
        }else{
            cell.aceptar.isHidden = false
            cell.rechazo.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let rechazar = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
                    completion(true)
                }
        
        respuestasDM.updateCumple(index: indexPath.row, cumple: "No Cumple")
        
        self.RespuestaTable.reloadData()
        
        rechazar.backgroundColor = UIColor(red: 1.00, green: 0.23, blue: 0.19, alpha: 0.00)
        rechazar.image = UIImage.init(named: "xmark")
        
                let config = UISwipeActionsConfiguration(actions: [rechazar])
                config.performsFirstActionWithFullSwipe = true
             
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let aceptar = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
                    completion(true)
            
        }
        
        respuestasDM.updateCumple(index: indexPath.row, cumple: "Cumple")
        
        self.RespuestaTable.reloadData()
        
        aceptar.backgroundColor = UIColor(red: 0.45, green: 0.95, blue: 0.44, alpha: 0.00)
        
        aceptar.image = UIImage.init(named: "checkmark")
        
        let config = UISwipeActionsConfiguration(actions: [aceptar])
        config.performsFirstActionWithFullSwipe = true
     
        return config
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.respuestasDM.fetch(id_recorrido: currentRecorrido, id_empleado: currentEmpleado)
        // Do any additional setup after loading the view.
    }

}
