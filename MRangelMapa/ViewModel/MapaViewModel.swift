//
//  MapaViewModel.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 22/03/23.
//

import Foundation

class MapaViewModel{
    
    var places = PlacesModel()
    var place = PlaceModel()
    var placeDetail = PlaceDetailModel(result: Place(place_id: "", current_opening_hours: current_opening_hours(weekday_text: [""]), geometry: geometry(location: location(lat: 0, lng: 0)), formatted_phone_number: "", name: "", website: "", rating: 0))
    //var placeDetail = PlaceDetailModel
    
    func GetPlaces(name : String, places : @escaping(PlacesModel?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(name)%20in%20Mexico&key=AIzaSyDLGtXTw5rvpXPxSYRufGGYrv1kPXm5VY8")
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else{
                return
            }
            self.places = try! decoder.decode(PlacesModel.self, from: data)
            places(self.places, nil)
            
            if let error = error {
                places(nil,error)
            }
        }.resume()
    }
    
    func GetDetails(idPlace: String, placeDetail: @escaping(PlaceDetailModel?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?&place_id=\(idPlace)&key=AIzaSyDLGtXTw5rvpXPxSYRufGGYrv1kPXm5VY8")
        urlSession.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            self.placeDetail = try! decoder.decode(PlaceDetailModel.self, from: data)
            placeDetail(self.placeDetail, nil)
            
            if let error = error {
                placeDetail(nil, error)
            }
        }.resume()
    }
    
    
}
