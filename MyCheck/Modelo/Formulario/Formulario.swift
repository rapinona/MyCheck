//
//  Empleado.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import Foundation

// MARK: - Empleado
struct Formulario: Codable {
    var id: Int
    var Formulario: String

    enum CodingKeys: String, CodingKey {
        case id, Formulario
    }
    
    init(identifier: Int,name: String) {
        id = identifier
        Formulario = name
    }
}
