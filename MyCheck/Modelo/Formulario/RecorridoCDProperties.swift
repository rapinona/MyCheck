//
//  Task+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Piñón Ayala Rodrigo  on 24/09/22.
//
//

import Foundation
import CoreData


extension FormularioCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FormularioCD> {
        return NSFetchRequest<FormularioCD>(entityName: "FormularioCD")
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var formulario: String?


}

extension FormularioCD : Identifiable {

}
