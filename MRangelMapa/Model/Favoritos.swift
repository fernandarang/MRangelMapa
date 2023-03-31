//
//  Favoritos.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 27/03/23.
//

import Foundation
struct FavoritosModel{
    var place_id : String
    var name : String
    var formatted_address : String
    var user_ratings_total : Int
    var rating : Double
    
    init(place_id: String, name: String, formatted_address: String, user_ratings_total: Int, rating: Double) {
        self.place_id = place_id
        self.name = name
        self.formatted_address = formatted_address
        self.user_ratings_total = user_ratings_total
        self.rating = rating
    }
    init(){
        self.place_id = ""
        self.name = ""
        self.formatted_address = ""
        self.user_ratings_total = 0
        self.rating = 0
    }
}
