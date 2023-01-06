//
//  EstatusViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 07/09/22.
//

import UIKit

class EstatusViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate{
    
    let estatusDM = EstatusDataManager()
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    var recorridoDM : RecorridosDataManager?
    var selectedEstatus: Int = 0
    var todosRecorridos : [Recorrido]?
    var currentRecorrido: Recorrido?
    
    @IBOutlet var EstatusCollectionView: UICollectionView!
    @IBOutlet var RecorridoTable: UITableView!
    @IBOutlet var Swipe: UISwipeGestureRecognizer!
    
    
    //Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        estatusDM.estatusCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "estatus", for: indexPath) as! EstatusCollectionViewCell
        
        if(indexPath.row==selectedEstatus){
            cell=enable(cell: cell,text: estatusDM.estatusAt(index: indexPath.row))
            return cell
        }
        cell=disable(cell: cell,text: estatusDM.estatusAt(index: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        self.selectedEstatus = indexPath.row
        self.EstatusCollectionView.reloadData()
        self.RecorridoTable.reloadData()
        self.EstatusCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //Formato al collection view cell
    func enable(cell : EstatusCollectionViewCell, text:String? = nil) -> EstatusCollectionViewCell{
        
        if text != nil {
            cell.EstatusLabel.text = text
        }
        cell.EstatusView.layer.backgroundColor = CGColor.init(srgbRed: 36.0, green: 52.0, blue: 71.0, alpha: 0.5)
        
        return cell
    }
    
    func disable(cell : EstatusCollectionViewCell,text:String? = nil) -> EstatusCollectionViewCell{
        
        if text != nil {
            cell.EstatusLabel.text = text
        }
        cell.EstatusView.layer.backgroundColor = CGColor.init(srgbRed: 36.0, green: 52.0, blue: 71.0, alpha: 0.0)
        
        return cell
    }
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedEstatus {
        case 0:
            return recorridoDM!.enviadosCount()
        case 1:
            return recorridoDM!.recibidosCount()
        case 2:
            return recorridoDM!.enProcesoCount()
        case 3:
            print(recorridoDM!.CompletadosCount())
            return recorridoDM!.CompletadosCount()
        default:
            print("salio mal")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recorrido", for: indexPath) as! RecorridoTableViewCell
        
        let recorrido : Recorrido?
        
        switch selectedEstatus {
        case 0:
            recorrido = recorridoDM!.enviadosAt(index: indexPath.row)
        case 1:
            recorrido = recorridoDM!.recibidosAt(index: indexPath.row)
            print(recorrido ?? "error")
        case 2:
            recorrido = recorridoDM!.enProcesoAt(index: indexPath.row)
        case 3:
            recorrido = recorridoDM!.completadosAt(index: indexPath.row)
        default:
            recorrido = recorridoDM!.recorridoAt(index: indexPath.row)
        }
        
        cell.nombre.text = recorrido?.nombre
        cell.fecha_fin.text = recorrido?.fecha_fin
        cell.tienda.text = recorrido?.descripcion
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectedEstatus {
        case 0:
            currentRecorrido = recorridoDM!.enviadosAt(index: indexPath.row)
        case 1:
            currentRecorrido = recorridoDM!.recibidosAt(index: indexPath.row)
        case 2:
            currentRecorrido = recorridoDM!.enProcesoAt(index: indexPath.row)
        case 3:
            currentRecorrido = recorridoDM!.completadosAt(index: indexPath.row)
        default:
            currentRecorrido = recorridoDM!.recorridoAt(index: indexPath.row)
        }
        self.performSegue(withIdentifier: "detalles", sender: Self.self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetallesRecorridoViewController
        destination.currentRecorrido = currentRecorrido!
    }
    
    
    @IBAction func Left(_ sender: UISwipeGestureRecognizer) {
        if(self.selectedEstatus==0){
            self.selectedEstatus = self.estatusDM.estatusCount()-1
        }else{
            self.selectedEstatus = self.selectedEstatus-1
        }
        let indexPath = IndexPath(row: selectedEstatus, section: 0)
        self.EstatusCollectionView.reloadData()
        self.RecorridoTable.reloadData()

        self.EstatusCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func Rigth(_ sender: Any) {
        if(self.selectedEstatus==self.estatusDM.estatusCount()-1){
            self.selectedEstatus = 0
        }else{
            self.selectedEstatus = self.selectedEstatus+1
        }
        let indexPath = IndexPath(row: selectedEstatus, section: 0)
        self.EstatusCollectionView.reloadData()
        self.RecorridoTable.reloadData()

        self.EstatusCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indexPath = IndexPath(row: self.selectedEstatus, section: 0)
        
        recorridoDM = RecorridosDataManager(context:context)
        self.recorridoDM!.fetch(anteriores: self.todosRecorridos!,context: context){
            DispatchQueue.main.async {
                self.RecorridoTable.reloadData()
            }
        }
        
        self.EstatusCollectionView.layoutIfNeeded()
        self.EstatusCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        // Do any additional setup after loading the view.
    }

}
