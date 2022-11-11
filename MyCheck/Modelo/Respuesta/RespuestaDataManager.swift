//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class RespuestaDataManager{
    
    private var respuestas : [Respuesta] = []
    
    func fetch(id_recorrido:Int,id_empleado:Int){
        if let file  = Bundle.main.url(forResource: "respuestas", withExtension: "json"){
            do{
                let data = try Data(contentsOf: file)
                let decodedRespuestas = try JSONDecoder().decode([Respuesta].self, from: data)
                respuestas = decodedRespuestas.filter { respuesta in
                    return (respuesta.id_recorrido == id_recorrido && respuesta.id_empleado == id_empleado)
                  }
            }catch{
                print("Error:",error)
            }
        }
    }
    
    func respuestasCount() -> Int{
        return respuestas.count
    }
    
    func respuestaAt(index:Int) -> Respuesta{
        return respuestas[index]
    }
    
    func updateCumple(index:Int,cumple:String){
        respuestas[index].cumple = cumple
        
        return
    }
    
}
