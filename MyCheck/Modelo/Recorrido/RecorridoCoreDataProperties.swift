//
//  Task+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Piñón Ayala Rodrigo  on 24/09/22.
//
//

import Foundation
import CoreData


extension RecorridoCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecorridoCD> {
        return NSFetchRequest<RecorridoCD>(entityName: "RecorridoCD")
    }

    @NSManaged public var id_recorrido: NSNumber?
    @NSManaged public var nombre: String?
    @NSManaged public var descripcion: String?
    @NSManaged public var asignadoPor: String?
    @NSManaged public var fecha_inicio: String?
    @NSManaged public var fecha_fin: String?
    @NSManaged public var status: NSNumber?


}

extension RecorridoCD : Identifiable {

}
