//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class RespuestaDataManager{
    
    private var respuestas : [Respuesta] = []
    
    func fetch(id_recorrido : Int,id_empleado : Int,completion: @escaping () -> Void){
        
        guard let laURL = URL(string: "https://my.api.mockaroo.com/respuestas/"+String(id_recorrido)+"/"+String(id_empleado)+".json")
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
                    let results = try JSONDecoder().decode([Respuesta].self,from: data)
                        self.respuestas = results
                        completion()
                    }
                catch{
                    print("Error en fetch")
                }
            }
        }
        task.resume()
    }
    
    func respuestasCount() -> Int{
        return respuestas.count
    }
    
    func respuestaAt(index:Int) -> Respuesta{
        return respuestas[index]
    }
    
    func updateCumple(index:Int,cumple:Bool){
        respuestas[index].cumple = cumple
        
        return
    }
    
}
