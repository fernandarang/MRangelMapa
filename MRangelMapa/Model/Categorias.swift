//
//  Categorias.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import Foundation

struct CategoriasModel{
    var idCategoria : Int
    var nombre : String
    
    init(idCategoria: Int, nombre: String) {
        self.idCategoria = idCategoria
        self.nombre = nombre
    }
    
    init(){
        self.idCategoria = 0
        self.nombre = ""
    }
}
