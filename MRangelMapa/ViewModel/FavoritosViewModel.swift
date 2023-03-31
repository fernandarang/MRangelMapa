//
//  FavoritosViewModel.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 27/03/23.
//

import Foundation
import UIKit
import CoreData

class FavoritosViewModel{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(favoritos : FavoritosModel) -> Result{
        
        var result = Result()
        
        do{
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Favoritos", in: context)
            let favoritosCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            
            favoritosCoreData.setValue(favoritos.place_id, forKey: "place_id")
            favoritosCoreData.setValue(favoritos.name, forKey: "name")
            favoritosCoreData.setValue(favoritos.formatted_address, forKey: "formatted_address")
            favoritosCoreData.setValue(favoritos.user_ratings_total, forKey: "user_ratings_total")
            favoritosCoreData.setValue(favoritos.rating, forKey: "rating")
            
            try! context.save()
            result.Correct = true
            
        }catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    func Delete(IdPlace : String) -> Result {
            var result = Result()
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Favoritos", in: context)
            let request : NSFetchRequest<Favoritos> = Favoritos.fetchRequest()
            request.entity = entidad
            let predicate = NSPredicate(format: "place_id contains %@", IdPlace)
            request.predicate = predicate
            do{
                var results = try! context.fetch(request)
                if results.isEmpty{
                    result.Correct = true
                }else {
                    let objDelete = results[0] as NSManagedObject
                    context.delete(objDelete)
                }
                
                try! context.save()
                
            }catch let error{
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
            return result
        }
    
    func GetAll() -> Result {
        var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoritos")
        
        do {
            let favoritos = try context.fetch(request)
            result.Objects = [FavoritosModel]()
            for objFavorito in favoritos as! [NSManagedObject] {
                var favorito = FavoritosModel()
                
                favorito.place_id = objFavorito.value(forKey: "place_id") as! String
                favorito.name = objFavorito.value(forKey: "name") as! String
                favorito.formatted_address = objFavorito.value(forKey: "formatted_address") as! String
                favorito.user_ratings_total = objFavorito.value(forKey: "user_ratings_total") as! Int
                favorito.rating = objFavorito.value(forKey: "rating") as! Double
                
                result.Objects?.append(favorito)
            }
            result.Correct = true
            
        } catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
}
