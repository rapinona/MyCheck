//
//  Empleado.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import Foundation

// MARK: - Puesto
struct Puesto: Codable {
    let id: Int
    let id_tienda: Int
    let puesto : String

    enum CodingKeys: String, CodingKey {
        case id, id_tienda, puesto
    }
}
