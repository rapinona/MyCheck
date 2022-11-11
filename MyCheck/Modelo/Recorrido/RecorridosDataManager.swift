//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class RecorridosDataManager{
    
    private var recorridos : [Recorrido] = []
    
    func fetch(){
        if let file  = Bundle.main.url(forResource: "recorridos", withExtension: "json"){
            do{
                let data = try Data(contentsOf: file)
                let decodedRecorridos = try JSONDecoder().decode([Recorrido].self, from: data)
                recorridos = decodedRecorridos
            }catch{
                print("Error:",error)
            }
        }
    }
    
    func recorridosCount() -> Int{
        return recorridos.count
    }
    
    func recorridoAt(index:Int) -> Recorrido{
        return recorridos[index]
    }
    
}
