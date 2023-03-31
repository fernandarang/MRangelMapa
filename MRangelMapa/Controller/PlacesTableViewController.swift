//
//  PlacesTableViewController.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import UIKit

class PlacesTableViewController: UITableViewController {

    var places = PlacesModel()
    var placesViewModel = MapaViewModel()
    var name : String? = nil
    var numero : Int = 0
    
    var idPlace: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PlaceTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadData()
    }

    func loadData(){
        placesViewModel.GetPlaces(name: self.name!, places: {requestdata, error in
            if let requestdata1 = requestdata {
                    self.places = requestdata1
                //print(self.places)
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        print(requestdata1.results)
                        //self.numero = self.places.results!.count
                        self.tableView.reloadData()
                        self.title = self.name
                    }
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceTableViewCell

        cell.nombreLugar.text = places.results[indexPath.row].name
        cell.direccionLugar.text = places.results[indexPath.row].formatted_address
        cell.ciudadLugar.text = "Rating total de usuarios: \( String(places.results[indexPath.row].user_ratings_total))"
        cell.raitingLugar.text = String(places.results[indexPath.row].rating)
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idPlace = places.results[indexPath.row].place_id
        self.performSegue(withIdentifier: "DetalleSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleSegue"{
            let detalleController = segue.destination as! DetalleViewController
            detalleController.idPlace = self.idPlace
        }
        if segue.identifier == "mapSegue"{
            let mapController = segue.destination as! PlacesMapaViewController
            mapController.nombre = self.name
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
