//
//  DetallesRecorridoViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import UIKit
import Network

class DetallesRecorridoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {


    var currentEmpleado : EmpleadoAsignado?
    var currentRecorrido : Recorrido?
    var empleadoDM : EmpleadoDataManager?
    @IBOutlet var DescripcionRecorrido: UITextView!
    @IBOutlet var NombreRecorrido: UILabel!
    @IBOutlet var FechaInicio: UILabel!
    @IBOutlet var FechaFin: UILabel!
    @IBOutlet var EmpleadosTable: UITableView!
    
    
    //EMPLEADOS TABLE

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleadoDM!.empleadosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "empleado", for: indexPath) as! EmpleadoTableViewCell
        
        let empleado = empleadoDM!.empleadoAt(index: indexPath.row)
        
        cell.NombreEmpleado.text = empleado.nombre
        cell.TiendaEmpleado.text = empleado.tienda
        switch empleado.status{
        case 0:
            cell.statusEmpleado.text="Enviadas"
        case 1:
            cell.statusEmpleado.text="Recibidas"
        case 2:
            cell.statusEmpleado.text="En Proceso"
        case 3:
            cell.statusEmpleado.text="Completadas"
        default:
            cell.statusEmpleado.text="Enviadas"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentEmpleado = empleadoDM?.empleadoAt(index: indexPath.row)
        
        self.performSegue(withIdentifier: "respuestas", sender: Self.self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RespuestasViewController
        destination.currentRecorrido = currentRecorrido!.id_recorrido
        destination.currentEmpleado = currentEmpleado!.id_empleado
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        empleadoDM = EmpleadoDataManager()
        
        empleadoDM!.fetch(id_recorrido: currentRecorrido!.id_recorrido){
            DispatchQueue.main.async {
                self.EmpleadosTable.reloadData()
                self.NombreRecorrido.text = self.currentRecorrido!.nombre
                self.DescripcionRecorrido.text = self.currentRecorrido!.descripcion
                self.FechaInicio.text = self.currentRecorrido!.fecha_inicio
                self.FechaFin.text = self.currentRecorrido!.fecha_fin
            }
        }
        
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                let alert = UIAlertController(title: "My Team", message: "No hay conexión a internet.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }
    

}
