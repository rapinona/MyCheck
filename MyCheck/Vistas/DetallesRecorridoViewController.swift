//
//  DetallesRecorridoViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import UIKit

class DetallesRecorridoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {


    var currentEmpleado = 315297128
    var currentRecorrido : Recorrido?
    let empleadoDM = EmpleadoDataManager()
    
    @IBOutlet var NombreRecorrido: UILabel!
    @IBOutlet var DescripcionRecorrido: UILabel!
    @IBOutlet var FechaInicio: UILabel!
    @IBOutlet var FechaFin: UILabel!
    @IBOutlet var EmpleadosTable: UITableView!
    
    //EMPLEADOS TABLE
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Enviadas"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleadoDM.empleadosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "empleado", for: indexPath) as! EmpleadoTableViewCell
        
        let empleado = empleadoDM.empleadoAt(index: indexPath.row)
        
        cell.NombreEmpleado.text = empleado.nombre
        cell.TiendaEmpleado.text = empleado.tienda
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentEmpleado = empleadoDM.empleadoAt(index: indexPath.row).id_empleado
        
        self.performSegue(withIdentifier: "respuestas", sender: Self.self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RespuestasViewController
        destination.currentRecorrido = currentRecorrido!.id
        destination.currentEmpleado = currentEmpleado
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.empleadoDM.fetch(id_recorrido: currentRecorrido!.id)
        
        self.NombreRecorrido.text = currentRecorrido!.nombre
        self.DescripcionRecorrido.text = currentRecorrido!.descripcion
        self.FechaInicio.text = currentRecorrido!.fecha_inicio
        self.FechaFin.text = currentRecorrido!.fecha_fin
        // Do any additional setup after loading the view.
    }
    

}
