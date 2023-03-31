//
//  DetalleViewController.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 23/03/23.
//

import UIKit
import MapKit
import CoreLocation

class DetalleViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var DetalleTableView: UITableView!
    @IBOutlet weak var AddFavoritos: UIButton!
    
    
    var locationManager = CLLocationManager()
    var favoritosViewModel = FavoritosViewModel()
    var placeDetails = PlaceDetailModel()
    var idPlace : String? = nil
    let mapaViewModel = MapaViewModel()
    var Secciones1 = [Datos]()
    var favorito = FavoritosModel()
    var lugares = Place()
    //var lugar = PlaceDetailModel()
    
    @IBAction func AddFavoritos(_ sender: UIButton) {
        if favorito != nil{
            AddFavoritos.tintColor = .red
        }
        
        //print(ingredientes)
        favorito = FavoritosModel(place_id: lugares.place_id!, name: lugares.name!, formatted_address: lugares.formatted_address!, user_ratings_total: lugares.user_ratings_total!, rating: lugares.rating ?? 0.0)
        let result = favoritosViewModel.Add(favoritos: favorito)
        
        if result.Correct{
            let alert = UIAlertController(title: "Confirmación", message: "Cocktail agregado a favoritos correctamente", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                            { action in
            })
            alert.addAction(Aceptar)
            self.present(alert, animated: false)
        }else{
            
            let alertError = UIAlertController(title: "Error", message: "El cocktail no se pudo agregar a favoritos"+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetalleTableView.delegate = self
        DetalleTableView.dataSource = self

        userLocalization()

        detalle()
        
        DetalleTableView.register(UINib(nibName: "DetalleTableViewCell", bundle: nil), forCellReuseIdentifier: "DetalleCell")
    }
    
    
    
    func userLocalization(){
        locationManager.delegate = self
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if #available(iOS 14.0, *) {
                switch manager.authorizationStatus {
                case .notDetermined:
                    print("Not determined")
                case .restricted:
                    print("Restricted")
                case .denied:
                    print("Denied")
                case .authorizedAlways:
                    print("Authorized Always")
                case .authorizedWhenInUse:
                    print("Authorized When in Use")
                @unknown default:
                    print("Unknown status")
                }
            }
        }
    
    func detalle(){
        mapaViewModel.GetDetails(idPlace: idPlace!, placeDetail: { requestdata, error in
            if let requestdata1 = requestdata {
                self.lugares = requestdata1.result as Place
                DispatchQueue.global().async {
                    DispatchQueue.main.async { [self] in
                        let annotation1 = MKPointAnnotation()
                        annotation1.coordinate = CLLocationCoordinate2D(latitude: lugares.geometry.location.lat, longitude: lugares.geometry.location.lng)
                        annotation1.title = lugares.name // Optional
                        let mapCoordinates = MKCoordinateRegion(center: annotation1.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                        MapView.setRegion(mapCoordinates, animated: false)
                        self.MapView.addAnnotation(annotation1)
                        print(requestdata?.result)
                        let results = detalleSecciones(placeDetail: requestdata!)
                        if results != nil {
                            Secciones1 = results as [Datos]
                            DetalleTableView.reloadData()
                            self.title = lugares.name
                        }
                    }
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
    }
    

    func detalleSecciones(placeDetail : PlaceDetailModel) -> [Datos]{
        var secciones = [Datos]()
        for seccion in 0...4 {
            if seccion == 0{
                var arreglo = [String]()
                arreglo.append(placeDetail.result.name ?? "Sin información")
                let seccion1 = Datos(Secciones: "NOMBRE DEL LUGAR", Datos: arreglo)
                secciones.append(seccion1)
            }
            if seccion == 1{
                var arreglo = [String]()
                arreglo.append(placeDetail.result.formatted_phone_number ?? "Sin Información")
                arreglo.append(placeDetail.result.website ?? "Sin Información")
                let seccion2 = Datos(Secciones: "CONTACTO", Datos: arreglo)
                secciones.append(seccion2)
            }
            if seccion == 2{
                var arreglo = [String]()
                arreglo.append(placeDetail.result.formatted_address ?? "Sin Información")
                let seccion3 = Datos(Secciones: "DIRECCIÓN", Datos: arreglo)
                secciones.append(seccion3)
            }
            if seccion == 3{
                var arreglo = [String]()
                //arrreglo.append(placeDetail.result.current_opening_hours.weekday_text)
                let seccion4 = Datos(Secciones: "HORARIO", Datos: placeDetail.result.current_opening_hours?.weekday_text! ?? ["Sin Información"])
                secciones.append(seccion4)
            }
        }
        return secciones
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
extension DetalleViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Secciones1.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Secciones1[section].Datos.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Secciones1[section].Secciones
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalleCell", for: indexPath) as! DetalleTableViewCell
        cell.datosLbl.text = Secciones1[indexPath.section].Datos[indexPath.row]
        if indexPath.section == 0{
            cell.IconoContacto.isHidden = true
            cell.ViewIcono.isHidden = true
            cell.espacio.isHidden = false
        }
        if indexPath.section == 1{
            cell.IconoContacto.isHidden = false
            cell.ViewIcono.isHidden = false
            cell.espacio.isHidden = true
        }
        if indexPath.section == 2{
            cell.IconoContacto.isHidden = true
            cell.ViewIcono.isHidden = true
            cell.espacio.isHidden = false
        }
        if indexPath.section == 3{
            cell.IconoContacto.isHidden = true
            cell.ViewIcono.isHidden = true
            cell.espacio.isHidden = false
        }
        return cell
    }
    
    
}
