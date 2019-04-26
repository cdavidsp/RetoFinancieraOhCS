//
//  Client.swift
//  RetoFinancieraOh
//
//  Created by Cesar Sosa  on 24/04/19.
//  Copyright © 2019 Cesar Sosa . All rights reserved.
//

import UIKit

class Client {
    var nombres:String?
    var apellidos:String?
    var edad:String?
    var fechaNacimiento:String?
    
    init(nombres:String?, apellidos:String, edad:String?,fechaNacimiento:String? )
    {
        self.nombres = nombres
        self.apellidos = apellidos
        self.edad = edad
        self.fechaNacimiento = fechaNacimiento
    }
    func toAnyObject() -> [String: Any] {
        
        return ["nombres": self.nombres ?? "", "apellidos": self.apellidos ?? "" , "edad": self.edad ?? "", "fechaNacimiento": self.fechaNacimiento ?? ""]
    }
    
    
    
}
