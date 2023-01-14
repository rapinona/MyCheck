//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation
import CoreData
import UIKit

class RecorridosDataManager{
    
    private var recorridos : [Recorrido] = []
    private var enviados : [Recorrido] = []
    private var recibidos : [Recorrido] = []
    private var enProceso : [Recorrido] = []
    private var completados : [Recorrido] = []
    
    var recorridosCD : [RecorridoCD] = []
    private var context : NSManagedObjectContext
    
    
    init(context:NSManagedObjectContext){
        self.context = context
    }

    
    func fetchCD(context:NSManagedObjectContext) {
        do{
            self.recorridosCD = try self.context.fetch(RecorridoCD.fetchRequest())
            
            var array : [Recorrido] = []
            for val in self.recorridosCD{
                let aux = Recorrido(id_recorrido: val.id.hashValue, nombre: val.nombre ?? "", descripcion: val.descripcion ?? "", asignadoPor: val.asignadoPor ?? "", fecha_inicio: val.fecha_inicio ?? "", fecha_fin: val.fecha_fin ?? "", status: val.status as! Int)
                
                array.append(aux)
            }
            self.recorridos = array
            self.filtrado()
        }
        catch{
            print("Error al recuperar los datos.")
        }
    }

    
    func fetch(context:NSManagedObjectContext,completion: @escaping () -> Void){
        
        self.fetchCD(context:context)
        guard let laURL = URL(string: "https://my.api.mockaroo.com/caminata.json")
        else {return}
            
        var request = URLRequest(url: laURL)
        request.setValue("42d45cc0", forHTTPHeaderField: "X-API-Key")
        request.httpMethod = "GET"
        let session = URLSession.shared
            
        let task = session.dataTask(with: request) { (data, response, error) in
            // this is where the completion handler code goes
            if let error = error {
                print(error)
            }
                            
            if let data = data {
                do{
                    let results = try JSONDecoder().decode([Recorrido].self,from: data)
                            
                    if(self.recorridos.count == 0){
                        self.recorridos = results
                    }else{
                        self.recorridos = self.recorridos + results
                    }
                    self.filtrado()
                    completion()
                }
                catch{
                    print("Error en fetch")
                }
            }
        }
        task.resume()
    }
        
    
    func filtrado(){
        self.enviados = self.recorridos.filter { recorrido in
            return recorrido.status == 0
          }
        self.recibidos = self.recorridos.filter { recorrido in
            return recorrido.status == 1
          }
        self.enProceso = self.recorridos.filter { recorrido in
            return recorrido.status == 2
          }
        self.completados = self.recorridos.filter { recorrido in
            return recorrido.status == 3
          }
    }
    
    func procentajeEnviadas() -> Int{
        let enviadosTotal = enviados.count
        let total = recorridos.count
        var procentaje=0
        if(total != 0){
            procentaje = (enviadosTotal * 100) / total
        }
        return procentaje
    }
    
    func procentajeRecibidas() -> Int{
        let recibidosTotal = recibidos.count
        let total = recorridos.count
        var procentaje=0
        if(total != 0){
            procentaje = (recibidosTotal * 100) / total
        }
        return procentaje
    }
    
    func procentajeEnProceso() -> Int{
        let enProcesoTotal = enProceso.count
        let total = recorridos.count
        var procentaje=0
        if(total != 0){
            procentaje = (enProcesoTotal * 100) / total
        }
        return procentaje
    }
    
    func procentajeCompletadas() -> Int{
        let completadosTotal = completados.count
        let total = recorridos.count
        var procentaje=0
        if(total != 0){
            procentaje = (completadosTotal * 100) / total
        }
        return procentaje
    }
    
    func enviadosCount() -> Int{
        return enviados.count
    }
    
    func recibidosCount() -> Int{
        return recibidos.count
    }
    
    func enProcesoCount() -> Int{
        return enProceso.count
    }
    
    func CompletadosCount() -> Int{
        return completados.count
    }
    
    func recorridosCount() -> Int{
        return recorridos.count
    }
    
    func recorridoCDAt(ui:Int) -> RecorridoCD?{
        var pos = -1
        for (index, element) in self.recorridosCD.enumerated(){
            if(element.id.hashValue == ui){
                pos = index
            }
        }
        if(pos>=0){
            return recorridosCD[pos]
        }else{
            return nil
        }
    }
    
    func recorridoAt(index:Int) -> Recorrido{
        return recorridos[index]
    }
    
    func deleteEnviadosAt(index:Int) -> Void{
        enviados.remove(at: index)
    }
    
    func enviadosAt(index:Int) -> Recorrido{
        return enviados[index]
    }
    
    func recibidosAt(index:Int) -> Recorrido{
        return recibidos[index]
    }
    
    func deleteRecibidosAt(index:Int) -> Void{
        recibidos.remove(at: index)
    }
    
    func enProcesoAt(index:Int) -> Recorrido{
        return enProceso[index]
    }
    
    func deleteEnProcesoAt(index:Int) -> Void{
        enProceso.remove(at: index)
    }
    
    func completadosAt(index:Int) -> Recorrido{
        return completados[index]
    }
    
    func deleteCompletadosAt(index:Int) -> Void{
        completados.remove(at: index)
    }
    
    func todosRecorridos() -> [Recorrido]{
        return recorridos
    }
    
    func deleteRecorridosAt(index:Int) -> Void{
        recorridos.remove(at: index)
    }
    
    func editEnviadosAt(index:Int,context:NSManagedObjectContext,status:Int) -> Void{
        var currentRecorrido : Int = -1
        var i : Int = 0
        for element in self.recorridos{
            if(element.id_recorrido == enviados[index].id_recorrido){
                currentRecorrido = i
            }
            i = i + 1
        }
        
        if(currentRecorrido >= 0){
            let cd = self.recorridoCDAt(ui: self.recorridos[currentRecorrido].id_recorrido)
            if(cd != nil){
                cd?.status = ((status) as NSNumber)
                do{
                    try self.context.save()
                }
                catch{
                    
                }
            }
            self.recorridos[currentRecorrido].status = status
            self.filtrado()
        }
        
    }
    
    func editRecibidosAt(index:Int,context:NSManagedObjectContext,status:Int) -> Void{
        var currentRecorrido : Int = -1
        var i : Int = 0
        for element in self.recorridos{
            if(element.id_recorrido == recibidos[index].id_recorrido){
                currentRecorrido = i
            }
            i = i + 1
        }
        
        if(currentRecorrido >= 0){
            let cd = self.recorridoCDAt(ui: self.recorridos[currentRecorrido].id_recorrido)
            if(cd != nil){
                cd?.status = ((status) as NSNumber)
                do{
                    try self.context.save()
                }
                catch{
                    
                }
            }
            self.recorridos[currentRecorrido].status = status
            self.filtrado()
        }
    }
    
    func editEnProcesoAt(index:Int,context:NSManagedObjectContext,status:Int) -> Void{
        var currentRecorrido : Int = -1
        var i : Int = 0
        for element in self.recorridos{
            if(element.id_recorrido == enProceso[index].id_recorrido){
                currentRecorrido = i
            }
            i = i + 1
        }
        
        if(currentRecorrido >= 0){
            let cd = self.recorridoCDAt(ui: self.recorridos[currentRecorrido].id_recorrido)
            if(cd != nil){
                cd?.status = ((status) as NSNumber)
                do{
                    try self.context.save()
                }
                catch{
                    
                }
            }
            self.recorridos[currentRecorrido].status = status
            self.filtrado()
        }
    }
    
    func editComletadosAt(index:Int,context:NSManagedObjectContext,status:Int) -> Void{
        var currentRecorrido : Int = -1
        var i : Int = 0
        for element in self.recorridos{
            if(element.id_recorrido == completados[index].id_recorrido){
                currentRecorrido = i
            }
            i = i + 1
        }
        
        if(currentRecorrido >= 0){
            let cd = self.recorridoCDAt(ui: self.recorridos[currentRecorrido].id_recorrido)
            if(cd != nil){
                cd?.status = ((status) as NSNumber)
                do{
                    try self.context.save()
                }
                catch{
                    
                }
            }
            self.recorridos[currentRecorrido].status = status
            self.filtrado()
        }
    }
    
}
