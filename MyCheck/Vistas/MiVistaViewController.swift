//
//  MiVistaViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 07/09/22.
//

import UIKit
import SideMenu

class MiVistaViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var EstatusCard: UICollectionView!
    @IBOutlet var recorridoTableView: UITableView!
    
    let estatusDM = EstatusDataManager()
    let recorridoDM = RecorridosDataManager()
    var selectedEstatus: Int = 0
    var currentRecorrido: Recorrido?
    
    //Collection view para las cards
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        estatusDM.estatusCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "estatusMiVista", for: indexPath) as! MiVistaEstatusCollectionViewCell
        
        cell.EstatusLabel.text = estatusDM.estatusAt(index: indexPath.row)
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
        recorridoDM.recorridosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recorrido", for: indexPath) as! RecorridoTableViewCell
        
        let recorrido = recorridoDM.recorridoAt(index: indexPath.row)
        
        cell.nombre.text = recorrido.nombre
        cell.fecha_fin.text = recorrido.fecha_fin
        cell.tienda.text = recorrido.descripcion
        
        print(recorrido.nombre)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRecorrido = recorridoDM.recorridoAt(index: indexPath.row)
        self.performSegue(withIdentifier: "detalles", sender: Self.self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalles" {
            
            
            let destination = segue.destination as! DetallesRecorridoViewController
            destination.currentRecorrido = currentRecorrido!
            
        }else{
            
            let destination = segue.destination as! EstatusViewController
            destination.selectedEstatus = self.selectedEstatus
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
        
        self.recorridoDM.fetch()
        // Do any additional setup after loading the view.
    }

}
