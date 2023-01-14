//
//  NuevoRecorridoViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import UIKit
import iOSDropDown

class NuevoRecorridoViewController: UIViewController {
    
    
    @IBOutlet weak var dropdownRecorrido: DropDown!
    @IBOutlet var fecha_inicio: UIDatePicker!
    @IBOutlet var fecha_fin: UIDatePicker!
    @IBOutlet var colabs_agregados: UILabel!
    
    var colabs : [String]?
    let tiendasDM = TiendaDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var formulariosDM : FormulariosDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.selectedIndex=1
        
        formulariosDM = FormulariosDataManager(context: self.context)
        var array : [String] = []
        self.formulariosDM?.fetchCD()
        let size : [FormularioCD] = (self.formulariosDM?.todosFormularios())!
        for val in size{
            array.append(val.formulario ?? "")
        }
        self.dropdownRecorrido.optionArray = array
        
        //self.tiendasDM.fetch(){
          //  DispatchQueue.main.async {
            //    self.dropdownRecorrido.optionArray = self.tiendasDM.todasTiendasNombre()
                //Its Id Values and its optional
              //  self.dropdownRecorrido.optionIds = self.tiendasDM.todasTiendasID()
            //}
        //}

        dropdownRecorrido.selectedRowColor = UIColor(red: 0.45, green: 0.95, blue: 0.44, alpha: 1.00)
        dropdownRecorrido.checkMarkEnabled = false

        // Do any additional setup after loading the view.

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        formulariosDM = FormulariosDataManager(context: self.context)
        var array : [String] = []
        self.formulariosDM?.fetchCD()
        let size : [FormularioCD] = (self.formulariosDM?.todosFormularios())!
        for val in size{
            array.append(val.formulario ?? "")
        }
        self.dropdownRecorrido.optionArray = array
    }
    
    
    @IBAction func cancelarRecorrido(_ sender: Any) {

        self.tabBarController?.selectedIndex=1
    }
    
    @IBAction func agregarEmpleados(_ sender: Any) {
        self.performSegue(withIdentifier: "agregarEmpleados", sender: Self.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "agregarEmpleados"){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            
            let newRecorrido = RecorridoCD(context: self.context)
            
            newRecorrido.nombre = self.dropdownRecorrido.text
            newRecorrido.asignadoPor = "Rodrigo Pinon"
            newRecorrido.descripcion = ""
            newRecorrido.fecha_inicio = dateFormatter.string(from: self.fecha_inicio.date)
            newRecorrido.fecha_fin = dateFormatter.string(from: self.fecha_fin.date)
            newRecorrido.status = 0
            
            let destination = segue.destination as! AsignarRecorridoViewController
            destination.recorridoCD = newRecorrido

        }
    }
    
}
