//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class EmpleadoDataManager{
    
    private var empleados : [EmpleadoAsignado] = []
    
    func fetch( id_recorrido : Int, completion: @escaping () -> Void){
        guard let laURL = URL(string: "https://my.api.mockaroo.com/empleadoAsignado/"+String(id_recorrido)+".json")
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
                    let results = try JSONDecoder().decode([EmpleadoAsignado].self,from: data)
                    self.empleados = results
                    completion()
                }
                catch{
                    print("Error en fetch")
                }
            }
        }
        task.resume()
    }
    
    func empleadosCount() -> Int{
        return empleados.count
    }
    
    func empleadoAt(index:Int) -> EmpleadoAsignado{
        return empleados[index]
    }
    
}

