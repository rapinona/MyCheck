//
//  Estatus.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 07/09/22.
//

import Foundation

class EstatusDataManager{
    
    let estatus = ["Enviadas","Recibidas","En Proceso","Completada"]

    func estatusCount() -> Int{
        return estatus.count
    }

    func estatusAt(index: Int) -> String{
        return estatus[index]
    }

    func estatusValue(index:Int) -> String{
        estatus[index]
    }
}
