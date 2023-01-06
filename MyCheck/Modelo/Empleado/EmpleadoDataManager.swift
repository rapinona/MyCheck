//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class EmpleadosDataManager{
    
    private var empleados : [Empleado] = []
    
    func fetch(completion: @escaping () -> Void){
        guard let laURL = URL(string: "https://my.api.mockaroo.com/empleados.json")
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
                    let results = try JSONDecoder().decode([Empleado].self,from: data)
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
    
    func empleadoAt(index:Int) -> Empleado{
        return empleados[index]
    }
    
    func todosEmpleadosNombre() -> [String]{
        let nombres = empleados.map({$0.nombre + " " + $0.apellido})
        return nombres
    }
    
    func todosEmpleadosID() -> [Int]{
        let ids = empleados.map({$0.id})
        return ids
    }
    
}

