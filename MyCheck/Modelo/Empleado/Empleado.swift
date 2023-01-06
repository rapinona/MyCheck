//
//  Empleado.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import Foundation

// MARK: - Empleado
struct Empleado: Codable {
    let id: Int
    let nombre: String
    let apellido : String
    let email : String
    let gender : String

    enum CodingKeys: String, CodingKey {
        case id, nombre, apellido, email, gender
    }
}
