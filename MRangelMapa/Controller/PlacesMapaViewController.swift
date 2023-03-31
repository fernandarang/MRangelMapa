//
//  PlacesMapaViewController.swift
//  MRangelMapa
//
//  Created by MacBookMBA5 on 24/03/23.
//

import UIKit
import MapKit
import CoreLocation

class PlacesMapaViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var MapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var nombre : String? = nil
    var mapaViewModel = MapaViewModel()
    var ubicaciones = [PlaceModel]()
    var anotation : [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userLocalization()
        pines()
    }
    
    func userLocalization(){
        locationManager.delegate = self
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func pines(){
        mapaViewModel.GetPlaces(name: nombre!, places: {requestdata, error in
            DispatchQueue.global().async {
                DispatchQueue.main.async { [self] in
                    ubicaciones = requestdata?.results as! [PlaceModel]
                    for ubicacionesArray in ubicaciones{
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: ubicacionesArray.geometry.location.lat, longitude: ubicacionesArray.geometry.location.lng)
                        annotation.title = ubicacionesArray.name
                        anotation.append(annotation)
                    }
                    for annotationmap in anotation{
                     MapView.addAnnotation(annotationmap)
                        
                        let mapCoordinates = MKCoordinateRegion(center: annotationmap.coordinate, latitudinalMeters: 8000, longitudinalMeters: 8000)
                        MapView.setRegion(mapCoordinates, animated: true)
                    }
                }
                
                
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
