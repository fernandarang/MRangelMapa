//
//  PlaceDetail.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import Foundation

struct PlaceDetailModel : Codable{
    var result : Place
    
    init(result: Place) {
        self.result = result
    }
    init(){
        self.result = Place()
    }
}
struct Place : Codable{
    var place_id : String?
    var current_opening_hours : current_opening_hours?
    var geometry : geometry
    var formatted_phone_number : String?
    var name : String?
    var website : String?
    var formatted_address : String?
    var user_ratings_total : Int?
    var rating : Double?
    
    init(place_id: String? = nil, current_opening_hours: current_opening_hours, geometry: geometry, formatted_phone_number: String? = nil, name: String? = nil, website: String? = nil, formatted_address: String? = nil, user_ratings_total: Int? = nil, rating: Double) {
        self.place_id = place_id
        self.current_opening_hours = current_opening_hours
        self.geometry = geometry
        self.formatted_phone_number = formatted_phone_number
        self.name = name
        self.website = website
        self.formatted_address = formatted_address
        self.user_ratings_total = user_ratings_total
        self.rating = rating
    }
    
    init(){
        self.place_id = ""
        self.current_opening_hours = MRangelMapa.current_opening_hours()
        self.geometry = MRangelMapa.geometry()
        self.formatted_phone_number = ""
        self.name = ""
        self.website = ""
        self.formatted_address = ""
        self.user_ratings_total = 0
        self.rating = 0
    }
    
}
struct current_opening_hours : Codable{
    var weekday_text : [String]?
    
    init(weekday_text: [String]? = nil) {
        self.weekday_text = weekday_text
    }
    
    init(){
        self.weekday_text = [String]()
    }
}
struct geometry : Codable{
    var location : location
    
    init(location: location) {
        self.location = location
    }
    
    init(){
        self.location = MRangelMapa.location()
    }
}
struct location : Codable{
    var lat : Double
    var lng : Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    init(){
        self.lat = 0
        self.lng = 0
    }
}

//Tabla detalle

//struct Detail{
//    var Detalle : [Datos]
//
//    init(Detalle: [Datos]) {
//        self.Detalle = Detalle
//    }
//
//    init(){
//        self.Detalle = [Datos]()
//    }
//}

struct Datos{
    var Secciones : String
    var Datos : [String]
    
    init(Secciones: String, Datos: [String]) {
        self.Secciones = Secciones
        self.Datos = Datos
    }
    
    init(){
        self.Secciones = ""
        self.Datos = []
    }
}
