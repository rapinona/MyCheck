//
//  MiVistaViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 07/09/22.
//

import UIKit
import SideMenu
import Network

class MiVistaViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var EstatusCard: UICollectionView!
    @IBOutlet var recorridoTableView: UITableView!
    
    let estatusDM = EstatusDataManager()
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    var recorridoDM : RecorridosDataManager?
    var selectedEstatus: Int = 0
    var currentRecorrido: Recorrido?
    var todosRecorridos : [Recorrido]?
    
    //Collection view para las cards
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        estatusDM.estatusCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "estatusMiVista", for: indexPath) as! MiVistaEstatusCollectionViewCell
        
        cell.EstatusLabel.text = estatusDM.estatusAt(index: indexPath.row)
        
        switch indexPath.row {
        case 0:
            cell.EstatusPercentage.text = String(recorridoDM!.procentajeEnviadas()) + "%"
            cell.EstatusProgress.progress = Float(recorridoDM!.procentajeEnviadas())/100
            cell.EstatusView.backgroundColor = UIColor(red: 0.81, green: 0.82, blue: 0.83, alpha: 1.00)
        case 1:
            cell.EstatusPercentage.text = String(recorridoDM!.procentajeRecibidas()) + "%"
            cell.EstatusProgress.progress = Float(recorridoDM!.procentajeRecibidas())/100
            cell.EstatusView.backgroundColor = UIColor(red: 0.72, green: 0.85, blue: 0.93, alpha: 1.00)
        case 2:
            cell.EstatusPercentage.text = String(recorridoDM!.procentajeEnProceso()) + "%"
            cell.EstatusProgress.progress = Float(recorridoDM!.procentajeEnProceso())/100
            cell.EstatusView.backgroundColor = UIColor(red: 0.95, green: 0.78, blue: 0.22, alpha: 1.00)
        case 3:
            cell.EstatusPercentage.text = String(recorridoDM!.procentajeCompletadas()) + "%"
            cell.EstatusProgress.progress = Float(recorridoDM!.procentajeCompletadas())/100
            cell.EstatusView.backgroundColor = UIColor(red: 0.45, green: 0.95, blue: 0.44, alpha: 1.00)
            
        default:
            cell.EstatusPercentage.text = "0"
        }
        
        cell.layer.cornerRadius = 20
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius: 20).cgPath
        cell.layer.shadowRadius = 1
        cell.layer.shadowOffset = .zero
        cell.layer.shadowOpacity = 1
        cell.layer.shadowColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        self.selectedEstatus = indexPath.row
        self.performSegue(withIdentifier: "estatus", sender: Self.self)
    }
    
    //tabla para los recorridos
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recorridoDM!.recorridosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recorrido", for: indexPath) as! RecorridoTableViewCell
        
        let recorrido = recorridoDM!.recorridoAt(index: indexPath.row)
        
        cell.nombre.text = recorrido.nombre
        cell.fecha_fin.text = recorrido.fecha_fin
        cell.tienda.text = recorrido.descripcion
        
        print(recorrido.nombre)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRecorrido = recorridoDM!.recorridoAt(index: indexPath.row)
        self.performSegue(withIdentifier: "detalles", sender: Self.self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalles" {
            
            
            let destination = segue.destination as! DetallesRecorridoViewController
            destination.currentRecorrido = currentRecorrido!
            
        }else{
            
            let destination = segue.destination as! EstatusViewController
            destination.selectedEstatus = self.selectedEstatus
            destination.todosRecorridos = todosRecorridos
        }
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuNavigationController
        present(menu, animated: true,completion: nil)
    }
    
    
    @IBAction func showSideMenuSwipe(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuNavigationController
        present(menu, animated: true,completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorridoDM = RecorridosDataManager(context:context)

        recorridoDM!.fetch(context:context){
            DispatchQueue.main.async {
                self.recorridoTableView.reloadData()
                self.EstatusCard.reloadData()
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
