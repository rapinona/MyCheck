//
//  Empleado.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import Foundation

struct Empleado :Decodable {
    
    let id_recorrido : Int
    let id_empleado:Int
    let nombre : String
    let tienda : String
    
    enum CodingKeys : String , CodingKey{
        case id_recorrido
        case id_empleado
        case nombre
        case tienda
    }

}
