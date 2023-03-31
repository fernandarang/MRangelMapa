//
//  Place.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 22/03/23.
//

import Foundation

struct PlacesModel : Codable{
    var results : [PlaceModel]
    
//    enum CodingKeys : String, CodingKey{
//        case results
//    }
    
    init(results: [PlaceModel]) {
        self.results = results
    }
    init(){
        self.results = [PlaceModel]()
    }
}

struct PlaceModel : Codable{
    var formatted_address : String
    var name : String
    var rating : Double
    var user_ratings_total : Int
    var place_id : String
    var geometry : geometryModel
    
//    enum CodingKeys : String, CodingKey{
//        case formattedAddress = "formatted_address"
//        case compoundCode = "compound_code"
//    }
    
    init(formatted_address: String, name: String, rating: Double, user_ratings_total: Int, place_id: String, geometry : geometryModel) {
        self.formatted_address = formatted_address
        self.name = name
        self.rating = rating
        self.user_ratings_total = user_ratings_total
        self.place_id = place_id
        self.geometry = geometry
    }
    
    init(){
        self.formatted_address = ""
        self.name = ""
        self.rating = 0
        self.user_ratings_total = 0
        self.place_id = ""
        self.geometry = geometryModel(location: locationModel(lat: 0, lng: 0))
    }
}

struct geometryModel : Codable{
    var location : locationModel
}
struct locationModel : Codable{
    var lat : Double
    var lng : Double
}


