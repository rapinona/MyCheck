//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class TiendaDataManager{
    
    private var tiendas : [Tienda] = []
    var internetStatus = false
    
    func fetch(completion: @escaping () -> Void){
        
        guard let laURL = URL(string: "https://my.api.mockaroo.com/tiendas.json")
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
                    let results = try JSONDecoder().decode([Tienda].self,from: data)
                    self.tiendas = results
                    completion()
                }
                catch{
                    print("Error en fetch")
                }
            }
        }
        task.resume()
    }
    
    func tiendasCount() -> Int{
        return tiendas.count
    }
    
    func tiendaAt(index:Int) -> Tienda{
        return tiendas[index]
    }
    
    func todasTiendasNombre() -> [String]{
        let nombres = tiendas.map({$0.tienda})
        return nombres
    }
    
    func todasTiendasID() -> [Int]{
        let ids = tiendas.map({$0.id})
        return ids
    }
    
}

