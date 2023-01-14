//
//  AsignarRecorridoViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 13/09/22.
//

import UIKit
import RSSelectionMenu
import Network


class AsignarRecorridoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nombre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "empleado", for: indexPath) as! SoloEmpleadoTableViewCell
        
        cell.nombre.text = nombre[indexPath.row]
        
        return cell
    }
    

    
    @IBOutlet var empeladoTable: UITableView!
    var tiendaOpciones = [String]()
    var tienda = [String]()
    @IBOutlet var tiendaBtn: UIButton!
    @IBOutlet var todasTiendasBtn: UIButton!
    
    var puestoOpciones = [String]()
    var puesto = [String]()
    @IBOutlet var puestoBtn: UIButton!
    @IBOutlet var todosPuestosBtn: UIButton!
    
    var nombreOpciones = [String]()
    var nombre = [String]()
    @IBOutlet var nombreBtn: UIButton!
    @IBOutlet var todosNombresBtn: UIButton!
    
    let tiendasDM = TiendaDataManager()
    let puestoDM = PuestoDataManager()
    let empleadoDM = EmpleadosDataManager()
    var recorridoCD : RecorridoCD?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todasTiendasBtn.setTitle("Todas", for: .normal)
        self.todosPuestosBtn.setTitle("Todas", for: .normal)
        self.todosNombresBtn.setTitle("Todas", for: .normal)
        
        self.tiendasDM.fetch(){
            DispatchQueue.main.async {
                self.tiendaOpciones = self.tiendasDM.todasTiendasNombre()
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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func verTiendas(_ sender: Any) {
        let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: tiendaOpciones) { (cell, name, indexPath) in

            cell.textLabel?.text = name
            cell.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        
        selectionMenu.setSelectedItems(items: tienda) { [weak self] (item, index, isSelected, selectedItems) in

            // update your existing array with updated selected items, so when menu show menu next time, updated items will be default selected.
            self?.tienda = selectedItems
        }
        // show searchbar
        selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in

          // return filtered array based on any condition
          // here let's return array where name starts with specified search text

          return self?.tiendaOpciones.filter({ $0.lowercased().hasPrefix(searchText.lowercased()) }) ?? []
        }
        
        // set navigation bar title and attributes
        selectionMenu.setNavigationBar(title: "Tiendas", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white], barTintColor: .gray, tintColor: UIColor.white)

        // right barbutton title - Default is 'Done'
        selectionMenu.rightBarButtonTitle = "Todos"

        // left barbutton title - Default is 'Cancel'
        selectionMenu.leftBarButtonTitle = "Cerrar"

                
        selectionMenu.show(style: .alert(title: "Tiendas", action: "Cerrar", height: nil), from: self)
        
        selectionMenu.onDismiss = { [weak self] selectedItems in
            self?.tienda = selectedItems
            if(self?.tienda.count ?? 0>0){
                self?.tiendaBtn.setTitle((self?.tienda[0] ?? "")+"...", for: .normal)
            }else{
                self?.revision()
                self?.tiendaBtn.setTitle("Tienda...", for: .normal)
            }
            
            self?.puestoDM.fetch(){
                DispatchQueue.main.async {
                    self?.puestoOpciones = self?.puestoDM.todosPuestosNombre() ?? []
                }
            }
            
            // perform any operation once you get selected items
        }
    }
    
    @IBAction func verPuestos(_ sender: Any) {
        if(tienda.count==0){
            puestoOpciones=[]
        }
        let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: puestoOpciones) { (cell, name, indexPath) in

            cell.textLabel?.text = name
            cell.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        
        selectionMenu.setSelectedItems(items: puesto) { [weak self] (item, index, isSelected, selectedItems) in

            // update your existing array with updated selected items, so when menu show menu next time, updated items will be default selected.
            self?.puesto = selectedItems
        }
        // show searchbar
        selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in

          // return filtered array based on any condition
          // here let's return array where name starts with specified search text

          return self?.puestoOpciones.filter({ $0.lowercased().hasPrefix(searchText.lowercased()) }) ?? []
        }
        
        selectionMenu.show(style: .alert(title: "Puestos", action: nil, height: nil), from: self)
        
        selectionMenu.onDismiss = { [weak self] selectedItems in
            self?.puesto = selectedItems
            if(self?.puesto.count ?? 0>0){
                self?.puestoBtn.setTitle((self?.puesto[0] ?? "")+"...", for: .normal)
            }else{
                self?.revision()
                self?.puestoBtn.setTitle("Puesto...", for: .normal)
            }
            
            self?.empleadoDM.fetch(){
                DispatchQueue.main.async {
                    self?.nombreOpciones = self?.empleadoDM.todosEmpleadosNombre() ?? []
                }
            }
            
            // perform any operation once you get selected items
        }
    }
    
    @IBAction func verNombres(_ sender: Any) {
        if(puesto.count==0){
            nombreOpciones=[]
        }
        let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: nombreOpciones) { (cell, name, indexPath) in

            cell.textLabel?.text = name
            cell.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        
        selectionMenu.setSelectedItems(items: nombre) { [weak self] (item, index, isSelected, selectedItems) in

            // update your existing array with updated selected items, so when menu show menu next time, updated items will be default selected.
            self?.nombre = selectedItems
        }
        // show searchbar
        selectionMenu.showSearchBar { [weak self] (searchText) -> ([String]) in

          // return filtered array based on any condition
          // here let's return array where name starts with specified search text

          return self?.nombreOpciones.filter({ $0.lowercased().hasPrefix(searchText.lowercased()) }) ?? []
        }
        
        selectionMenu.show(style: .alert(title: "Nombres", action: nil, height: nil), from: self)
        
        selectionMenu.onDismiss = { [weak self] selectedItems in
            self?.nombre = selectedItems
            if(self?.nombre.count ?? 0>0){
                self?.nombreBtn.setTitle((self?.nombre[0] ?? "")+"...", for: .normal)
                self?.empeladoTable.reloadData()
            }else{
                self?.nombreBtn.setTitle("Nombre...", for: .normal)
                self?.empeladoTable.reloadData()
            }
            // perform any operation once you get selected items
        }
    }
    
    @IBAction func todasTiendas(_ sender: Any) {
        if(todasTiendasBtn.titleLabel?.text == "Todas"){
            self.tienda = self.tiendaOpciones
            self.todasTiendasBtn.setTitle("Ninguno", for: .normal)
            if(tienda.count>0){
                self.tiendaBtn.setTitle((self.tienda[0] )+"...", for: .normal)
            }
            self.puestoDM.fetch(){
                DispatchQueue.main.async {
                    self.puestoOpciones = self.puestoDM.todosPuestosNombre()
                }
            }
        }else{
            tienda=[]
            self.revision()
            self.todasTiendasBtn.setTitle("Todas", for: .normal)
            self.tiendaBtn.setTitle("Tienda...", for: .normal)
        }
    }
    
    @IBAction func todosPuestos(_ sender: Any) {
        if(todosPuestosBtn.titleLabel?.text == "Todas" && tienda.count>0){
            
            self.puesto = self.puestoOpciones
            self.todosPuestosBtn.setTitle("Ninguno", for: .normal)
            if(puesto.count>0){
                self.puestoBtn.setTitle((self.puesto[0] )+"...", for: .normal)
            }
            self.empleadoDM.fetch(){
                DispatchQueue.main.async {
                    self.nombreOpciones = self.empleadoDM.todosEmpleadosNombre()
                }
            }
        }else{
            puesto=[]
            self.revision()
            self.todosPuestosBtn.setTitle("Todas", for: .normal)
            self.puestoBtn.setTitle("Puesto...", for: .normal)
        }
    }
    
    @IBAction func todosNombres(_ sender: Any) {
        if(todosNombresBtn.titleLabel?.text == "Todas" && puesto.count>0){
            self.nombre = self.nombreOpciones
            self.todosNombresBtn.setTitle("Ninguno", for: .normal)
            if(nombre.count>0){
                self.nombreBtn.setTitle((self.nombre[0] )+"...", for: .normal)
            }
            empeladoTable.reloadData()

        }else{
            self.todosNombresBtn.setTitle("Todas", for: .normal)
            self.nombreBtn.setTitle("Nombre...", for: .normal)
            empeladoTable.reloadData()
        }
    }
    
    func revision(){
        if(tienda.count==0){
            puestoOpciones=[]
            puesto=[]
            self.puestoBtn.setTitle("Puesto...", for: .normal)
            self.todosPuestosBtn.setTitle("Todas", for: .normal)
            
            nombreOpciones=[]
            nombre=[]
            empeladoTable.reloadData()
        }
        if(puesto.count==0){
            nombreOpciones=[]
            nombre=[]
            empeladoTable.reloadData()
            self.nombreBtn.setTitle("Nombre...", for: .normal)
            self.todosNombresBtn.setTitle("Todas", for: .normal)
        }
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.selectedIndex=1

    }
    
    @IBAction func guardarRecorrido(_ sender: Any) {
    
        if(self.recorridoCD !== nil && self.nombre.count > 0){
            do{
                try self.context.save()
                navigationController?.popToRootViewController(animated: true)
                self.tabBarController?.selectedIndex=1
            }
            catch{
                print("Error info: \(error)")
            }
        }else{
            let alert = UIAlertController(title: "My Team", message: "No ha terminado de generar el recorrido.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
