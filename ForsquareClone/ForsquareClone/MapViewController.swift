//
//  MapViewController.swift
//  ForsquareClone
//
//  Created by Yasemin TOK on 2.09.2021.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
        
   
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //locationManager.stopUpdatingLocation() 
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.35, longitudeDelta: 0.35)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveButtonClicked() {
        
        //PARSE
        
        let placeModel = PlaceModel.sharedInstance
        
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName //isimleri vs. place modeldan almam lazım
        object["type"] =  placeModel.placeType
        object["comment"] = placeModel.placeComment
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(data: imageData)
        }
        
        object.saveInBackground { success, error in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error!", message: "Fields cannot be left blank", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
        
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseLocation(gestureRecognizer : UIGestureRecognizer) { //func içinde recognizer kullanabilmek için içine yazdık
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView) //touches mapview kullanılarak koordinatlara çevrilir
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
        }
        
    }
    


}
