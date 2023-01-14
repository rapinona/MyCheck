//
//  Empleado.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 12/09/22.
//

import Foundation

// MARK: - Empleado
struct Tienda: Codable {
    let id: Int
    let tienda: String

    enum CodingKeys: String, CodingKey {
        case id, tienda
    }
}
