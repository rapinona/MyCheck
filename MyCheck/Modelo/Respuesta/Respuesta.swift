//
//  Respuesta.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 10/09/22.
//

import Foundation

struct Respuesta :Decodable {
    
    let id_recorrido:Int
    let id_empleado : Int
    let pregunta : String
    let Observaciones : String
    let foto : String
    let categoria : String
    var cumple : String
    
    enum CodingKeys : String , CodingKey{
        case id_recorrido
        case id_empleado
        case pregunta
        case Observaciones
        case foto
        case categoria
        case cumple
    }

}
