//
//  Recorrido.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

struct Recorrido :Decodable {
    
    let id:Int
    let nombre : String
    let descripcion : String
    let asignadoPor : String
    let fecha_inicio : String
    let fecha_fin : String
    
    enum CodingKeys : String , CodingKey{
        case id
        case nombre
        case descripcion
        case asignadoPor
        case fecha_inicio
        case fecha_fin
    }

}
