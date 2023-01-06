//
//  Empleado.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import Foundation

// MARK: - Empleado
struct EmpleadoAsignado: Codable {
    let id_recorrido, id_empleado,status: Int
    let nombre, email, tienda, puesto: String

    enum CodingKeys: String, CodingKey {
        case id_recorrido, id_empleado, nombre, email, tienda, puesto, status
    }
}
