//
//  SelectViewController.swift
//  ForsquareClone
//
//  Created by Yasemin TOK on 2.09.2021.
//

import UIKit
import MapKit
import Parse

class SelectViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var selectNameLabel: UILabel!
    @IBOutlet weak var selectTypeLabel: UILabel!
    @IBOutlet weak var selectCommentLabel: UILabel!
    @IBOutlet weak var selectMapView: MKMapView!
    
    var choosenPlacesId = ""//bu idyi diğer taraftaki seçilen idye eşitleyebilelim
    
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        
        selectMapView.delegate = self
        

        
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenPlacesId) //tableviewde tıkladığım satırdaki verinin idsi veritabanındaki idye eşit olanları getir
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Fatal Error")
                
            } else {
               // print(objects)  //satırdaki her şeyi dizi içine alıp veriyor. hepsini yazdırdı.
                if objects != nil {
                    
                    let choosenPlaceObject = objects![0]
                    
                    //OBJECTS
                    
                    if let placeName = choosenPlaceObject.object(forKey: "name") as? String {
                        self.selectNameLabel.text = placeName
                    }
                    if let placeType = choosenPlaceObject.object(forKey: "type") as? String {
                        self.selectTypeLabel.text = placeType
                    }
                    if let placeComment = choosenPlaceObject.object(forKey: "comment") as? String {
                        self.selectCommentLabel.text = placeComment
                    }
                    
                    
                    if let placeLatitude = choosenPlaceObject.object(forKey: "latitude") as? String {
                        if let placeLatitudeDouble = Double(placeLatitude) {
                            self.choosenLatitude = placeLatitudeDouble //parsedan aldığım latitudeyi String olarak aldım Doublea çevirdim choosena kaydettim
                        }
                    }
                    if let placeLongitude = choosenPlaceObject.object(forKey: "longitude") as? String {
                        if let placeLongitudeDouble = Double(placeLongitude) {
                            self.choosenLongitude = placeLongitudeDouble
                        }
                    }
                    
                    
                    if let imageData = choosenPlaceObject.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { data, error in
                            if error == nil {
                                self.selectImageView.image = UIImage(data: data!)
                            } else {
                                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                            }
                        }
                    }
                    
                } else {
                    
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Fatal Error")
                    
                }
                
                //MAPS
                
                let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                let region = MKCoordinateRegion(center: location, span: span)
                
                self.selectMapView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.selectNameLabel.text!
                annotation.subtitle = self.selectTypeLabel.text!
                self.selectMapView.addAnnotation(annotation)
                
            }
        }
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if self.choosenLatitude != 0.0 && self.choosenLongitude != 0.0 {
            
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks { //? değişsin diye, eğer dizinin içi doluysa yeni bir diziye ata ve artık kullan
                    if placemark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.selectNameLabel.text!
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions) //arabayla nasıl gideceğimizi gösterir
                    }
                }
            }
            
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Coordinate Faults")
        }
        
    }


}
