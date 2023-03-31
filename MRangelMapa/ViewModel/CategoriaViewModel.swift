//
//  CategoriaViewModel.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import Foundation
import CoreData
import UIKit

class CategoriaViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(categoria : CategoriasModel) -> Result{
            var result = Result()
            
            do{
                let context = appDelegate.persistentContainer.viewContext
                let entidad = NSEntityDescription.entity(forEntityName: "Categorias", in: context)
                let categoriaCoreData = NSManagedObject(entity: entidad!, insertInto: context)
               
                categoriaCoreData.setValue(categoria.nombre, forKey: "nombre")
                
                try! context.save()
                result.Correct = true
                
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
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categorias")
                do {
                    let categorias = try context.fetch(request)
                    result.Objects = [CategoriasModel]()
                    for objCategoria in categorias as! [NSManagedObject] {
                        
                        var categoria = CategoriasModel()
                        categoria.idCategoria = Int(objCategoria.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!
                        categoria.nombre = objCategoria.value(forKey: "nombre") as! String
                        
                        result.Objects?.append(categoria)
                    }
                    result.Correct = true
                } catch let error {
                   
                }
                return result
            }
    
    func Update(IdCategoria : Int, categorias : CategoriasModel) -> Result{
        
        let precios = ViewController()
                var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categorias")
        request.predicate = NSPredicate(format: "SELF == %i", IdCategoria)
                do{
                    var results = try! context.fetch(request)
                   
                    let objUpdate = results[0] as! NSManagedObject
                    
                        objUpdate.setValue(categorias.nombre, forKey: "nombre")
                        
                        //try objUpdate.managedObjectContext?.save()
                    result.Correct = true
                    
                    try! context.save()
                    
                }catch let error{
                    result.Correct = false
                    result.Ex = error
                    result.ErrorMessage = error.localizedDescription
                }
                return result
    }
    
    func Delete(IdCategoria : Int) -> Result {
            var result = Result()
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Categorias", in: context)
            let request : NSFetchRequest<Categorias> = Categorias.fetchRequest()
            request.entity = entidad
            let predicate = NSPredicate(format: "SELF = \(IdCategoria)")
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
    
    func GetById(IdCategoria : Int) -> Result {
                var result = Result()
                let context = appDelegate.persistentContainer.viewContext
                let entidad = NSEntityDescription.entity(forEntityName: "Categorias", in: context)
                let request : NSFetchRequest<Categorias> = Categorias.fetchRequest()
                request.entity = entidad
                let predicate = NSPredicate(format: "SELF = \(IdCategoria)")
                request.predicate = predicate
                do {
                    let frutas = try context.fetch(request)
                    result.Object = [CategoriasModel]()
                    for objCategoria in frutas as [NSManagedObject] {
                        var Categoria = CategoriasModel()
                        Categoria.idCategoria = Int(objCategoria.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!
                        Categoria.nombre = objCategoria.value(forKey: "nombre") as! String
                        
                        result.Object = Categoria
                    }
                    result.Correct = true
                } catch {
                    result.Correct = false
                    result.Ex = error
                    result.ErrorMessage = error.localizedDescription            }
                return result
            }
    
    func GetByNombre(nombre : String) -> Result {
                var result = Result()
                let context = appDelegate.persistentContainer.viewContext
                let entidad = NSEntityDescription.entity(forEntityName: "Categorias", in: context)
                let request : NSFetchRequest<Categorias> = Categorias.fetchRequest()
                request.entity = entidad
                let predicate = NSPredicate(format: "nombre contains %@", nombre)
                request.predicate = predicate
                do {
                    let categorias = try context.fetch(request)
                    result.Objects = [CategoriasModel]()
                    for objCategorias in categorias as [NSManagedObject] {
                        var categoria = CategoriasModel()
                        //fruta.idFruta = Int(objFruta.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!
                        categoria.nombre = objCategorias.value(forKey: "nombre") as! String
                        
                        result.Objects?.append(categoria)
                    }
                    result.Correct = true
                } catch {
                    result.Correct = false
                    result.Ex = error
                    result.ErrorMessage = error.localizedDescription
                }
                return result
            }
    
}
