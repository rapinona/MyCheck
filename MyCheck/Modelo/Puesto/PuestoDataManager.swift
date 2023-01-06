//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class PuestoDataManager{
    
    private var puestos : [Puesto] = []
    
    func fetch(completion: @escaping () -> Void){
        guard let laURL = URL(string: "https://my.api.mockaroo.com/puestos.json")
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
                    let results = try JSONDecoder().decode([Puesto].self,from: data)
                    self.puestos = results
                    completion()
                }
                catch{
                    print("Error en fetch")
                }
            }
        }
        task.resume()
    }
    
    func puestosCount() -> Int{
        return puestos.count
    }
    
    func puestosAt(index:Int) -> Puesto{
        return puestos[index]
    }
    
    func todosPuestosNombre() -> [String]{
        let nombres = puestos.map({$0.puesto})
        return nombres
    }
    
    func todosPuestosID() -> [Int]{
        let ids = puestos.map({$0.id})
        return ids
    }
    
}

