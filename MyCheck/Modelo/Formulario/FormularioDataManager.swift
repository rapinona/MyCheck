//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation
import CoreData

class FormulariosDataManager{
    
    private var formularios : [Formulario] = []
    var formulariosCD : [FormularioCD] = []
    private var context : NSManagedObjectContext
    
    init(context:NSManagedObjectContext){
        self.context = context
    }
    
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

    
    func fetchCD() {
        do{
            self.formulariosCD = try self.context.fetch(FormularioCD.fetchRequest())
        }
        catch{
            print("Error al recuperar los datos.")
        }
    }
    
    func formularioCount() -> Int{
        return formulariosCD.count
    }
    
    func formularioAt(index:Int) -> FormularioCD{
        return formulariosCD[index]
    }
    
    func todosFormularios() -> [FormularioCD]{
        return formulariosCD
    }
    
}

