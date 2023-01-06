//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class FormulariosDataManager{
    
    private var formularios : [Formulario] = []
    
    func fetch(anteriores:[Formulario],completion: @escaping () -> Void){
        if(anteriores.count==0){
            guard let laURL = URL(string: "https://my.api.mockaroo.com/formularios.json")
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
                        let results = try JSONDecoder().decode([Formulario].self,from: data)
                        self.formularios = results
                        completion()
                    }
                    catch{
                        print("Error en fetch")
                    }
                }
            }
            task.resume()
        }else{
            self.formularios = anteriores
        }
    }
    
    func formularioCount() -> Int{
        return formularios.count
    }
    
    func formularioAt(index:Int) -> Formulario{
        return formularios[index]
    }
    
    func todosFormularios() -> [Formulario]{
        return formularios
    }
    
}

