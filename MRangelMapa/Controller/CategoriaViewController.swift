//
//  CategoriaViewController.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import UIKit

class CategoriaViewController: UIViewController {
    
    @IBOutlet weak var NombreField: UITextField!
    @IBOutlet weak var BtnSave: UIButton!
    
    
    var categorias = CategoriasModel()
    var categoriasViewModel = CategoriaViewModel()
    var idCategoria : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        validar()
    }
    
    func validar(){
        if idCategoria == nil{
            BtnSave.setTitle("Save", for: .normal)
            
            //ImagenFrutas.image = UIImage(named: "product")
        }else
        {
            BtnSave.setTitle("Update", for: .normal)
            let result = categoriasViewModel.GetById(IdCategoria: idCategoria!)
            if result.Correct{
                let categoria = result.Object as! CategoriasModel
                NombreField.text = categoria.nombre
            }
        }
    }
    
    @IBAction func BtnSave(_ sender: UIButton) {
        if BtnSave.currentTitle == "Save" {
        guard let nombre = NombreField.text, nombre != "" else {
            NombreField.placeholder = "Ingresa el nombre"
            return
        }
        
        categorias = CategoriasModel(idCategoria: 0, nombre: nombre)
        
        let result = categoriasViewModel.Add(categoria: categorias)
        
        if result.Correct{
            let alert = UIAlertController(title: "Confirmación", message: "Fruta agregada correctamente", preferredStyle: .alert)
            
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                            { action in
                self.NombreField.text = ""
            })
            
            alert.addAction(Aceptar)
            self.present(alert, animated: false)
            
        }else{
            
            let alertError = UIAlertController(title: "Error", message: "La fruta no se pudo agregar "+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: false)
        }
      }
        if BtnSave.currentTitle == "Update" {
            guard let nombre = NombreField.text, nombre != "" else {
                NombreField.placeholder = "Ingresa el nombre"
                return
            }
            
            categorias = CategoriasModel(idCategoria: Int(idCategoria!), nombre: nombre)
            
            let result = categoriasViewModel.Update(IdCategoria: idCategoria!, categorias: categorias)
            
            if result.Correct{
                let alert = UIAlertController(title: "Confirmación", message: "Fruta agregada correctamente", preferredStyle: .alert)
                
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                { action in
                    self.NombreField.text = ""
                })
                
                alert.addAction(Aceptar)
                self.present(alert, animated: false)
                
            }else{
                
                let alertError = UIAlertController(title: "Error", message: "La fruta no se pudo agregar "+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
