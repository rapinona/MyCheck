//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation
import CoreData

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
            print("Recuperamos")
            print(self.recorridosCD)
        }
        catch{
            print("Error al recuperar los datos.")
        }
    }

    
    func fetch(anteriores:[Recorrido],context:NSManagedObjectContext,completion: @escaping () -> Void){
        
        self.fetchCD(context:context)
        
        if(anteriores.count==0){
            guard let laURL = URL(string: "https://my.api.mockaroo.com/caminata.json")
            else {return}
            
            print(laURL)
            
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
                        self.recorridos = results
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
                        completion()
                    }
                    catch{
                        print("Error en fetch")
                    }
                }
            }
            task.resume()
        }else{
            self.recorridos = anteriores
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
            completion()
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
    
    func recorridoAt(index:Int) -> Recorrido{
        return recorridos[index]
    }
    
    func enviadosAt(index:Int) -> Recorrido{
        return enviados[index]
    }
    
    func recibidosAt(index:Int) -> Recorrido{
        return recibidos[index]
    }
    
    func enProcesoAt(index:Int) -> Recorrido{
        return enProceso[index]
    }
    
    func completadosAt(index:Int) -> Recorrido{
        return completados[index]
    }
    
    func todosRecorridos() -> [Recorrido]{
        return recorridos
    }
    
}
