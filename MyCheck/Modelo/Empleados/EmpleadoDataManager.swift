//
//  Recorridos.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 08/09/22.
//

import Foundation

class EmpleadoDataManager{
    
    private var empleados : [Empleado] = []
    
    func fetch( id_recorrido : Int){
        if let file  = Bundle.main.url(forResource: "empleados", withExtension: "json"){
            do{
                let data = try Data(contentsOf: file)
                let decodedEmpleados = try JSONDecoder().decode([Empleado].self, from: data)
                empleados = decodedEmpleados.filter {empleado in empleado.id_recorrido == id_recorrido}
            }catch{
                print("Error:",error)
            }
        }
    }
    
    func empleadosCount() -> Int{
        return empleados.count
    }
    
    func empleadoAt(index:Int) -> Empleado{
        return empleados[index]
    }
    
}

