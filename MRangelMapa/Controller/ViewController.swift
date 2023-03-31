//
//  ViewController.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 22/03/23.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var Busqueda: UITextField!
    @IBOutlet weak var CategoriasTableView: UITableView!
    @IBOutlet weak var Buscar: UISearchBar!
    
    var categoriaViewModel = CategoriaViewModel()
    var categorias = [CategoriasModel]()
    var nombre :String? = nil
    var places = PlacesModel()
    var idCategoria : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoriasTableView.delegate = self
        CategoriasTableView.dataSource = self
        
        CategoriasTableView.register(UINib(nibName: "CategoriasTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriaCell")
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func Options(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        let addAction = UIAlertAction(title: "Agregar Categoria", style: .default) { (_) in
            self.performSegue(withIdentifier: "AddSegue", sender: self)
        }
//        let favAction = UIAlertAction(title: "Lista de favoritos", style: .default) { _ in
//            self.performSegue(withIdentifier: "FavoritoSegue", sender: self)
//        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(addAction)
        //actionSheet.addAction(favAction)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            let result = categoriaViewModel.GetByNombre(nombre: searchText)
            if result.Correct{
                categorias = result.Objects as! [CategoriasModel]
                CategoriasTableView.reloadData()
            }
        }else{
            loadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func loadData() {
            let result = categoriaViewModel.GetAll()
            if result.Correct{
                categorias = result.Objects! as! [CategoriasModel]
                CategoriasTableView.reloadData()
                self.title = "AroundMe"
            }
            else{
                //ALERT
                let alertError = UIAlertController(title: "Error", message: "Error al mostrar las frutas "+result.ErrorMessage, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: false)
            }
        }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriaCell", for: indexPath) as! CategoriasTableViewCell
        
        cell.nombreLbl.text = categorias[indexPath.row].nombre
        
        if categorias[indexPath.row].nombre == "Bancos"{
            cell.ImagenCategoria.image = UIImage(named: "banco")
        }
        if categorias[indexPath.row].nombre == "Universidades"{
            cell.ImagenCategoria.image = UIImage(named: "colegio")
        }
        if categorias[indexPath.row].nombre == "Teatros"{
            cell.ImagenCategoria.image = UIImage(named: "mascaras-de-teatro")
        }
        if categorias[indexPath.row].nombre == "Cines"{
            cell.ImagenCategoria.image = UIImage(named: "claqueta")
        }
        if categorias[indexPath.row].nombre == "Hospitales"{
            cell.ImagenCategoria.image = UIImage(named: "hospital")
        }
        if categorias[indexPath.row].nombre == "Plazas"{
            cell.ImagenCategoria.image = UIImage(named: "centro-comercial")
        }
        if categorias[indexPath.row].nombre == "Gyms"{
            cell.ImagenCategoria.image = UIImage(named: "aptitud")
        }
        if categorias[indexPath.row].nombre == "Restaurantes"{
            cell.ImagenCategoria.image = UIImage(named: "restaurante")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nombre = categorias[indexPath.row].nombre
        self.performSegue(withIdentifier: "PlacesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlacesSegue"{
            let placesController = segue.destination as! PlacesTableViewController
                placesController.name = self.nombre
        }
        if segue.identifier == "UpdateSegue"{
            let categoriaController = segue.destination as! CategoriaViewController
            categoriaController.idCategoria = self.idCategoria
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Delete") {
            (action,view,completion) in
                self.idCategoria = self.categorias[indexPath.row].idCategoria
                let result = self.categoriaViewModel.Delete(IdCategoria: self.idCategoria!)
                    if result.Correct{
                                    
                    }else{
                                   
                    }
                       self.loadData()
                completion(true)
        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = UIContextualAction(style: .normal, title: "Update") {
            (action,view,completion) in
            self.idCategoria = self.categorias[indexPath.row].idCategoria
            self.performSegue(withIdentifier: "UpdateSegue", sender: self)
                completion(true)
        }
        action1.image = UIImage(systemName: "eraser.line.dashed")
        action1.backgroundColor = .cyan
        
        return UISwipeActionsConfiguration(actions: [action1])
    }
    
}
