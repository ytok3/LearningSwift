//
//  ViewController.swift
//  TravelBookProject
//
//  Created by Yasemin TOK on 20.08.2021.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var noteText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()//kullanıcıdan konum almak istersek kullanmak zorundayız
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    var selectedTitle = ""
    var selectedTitleID : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapview
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //kullanıcının konumu ne kadar keskin yani doğru olsun
        locationManager.requestWhenInUseAuthorization() //kullanıcının konumunu sadece benim uygulamamı kullanırken alsın.
        locationManager.startUpdatingLocation() //konumu almaya başladım.
        
        //gesture recognizer
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(choseLocation(gestureRecognizer:))) //uzun basınca çağırcak
        //selector'u gestureRecognizer'ı func içinde çağırmak ve kullanmak için bu şekilde yazdık
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)  //uzun çağırmayı ekledim.
        
        if selectedTitle != "" {
            //CoreData
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString) //idsi istediğim idString'e eşit olanları çağır
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let title  = result.value(forKey: "title") as? String {
                            annotationTitle = title
                            
                            if let subtitle = result.value(forKey: "subtitle") as? String {
                                annotationSubtitle = subtitle
                                
                                if let latitude = result.value(forKey: "latitude") as? Double {
                                    annotationLatitude = latitude
                                    
                                    if let longitude = result.value(forKey: "longitude") as? Double {
                                        annotationLongitude = longitude
                                        
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                        annotation.coordinate = coordinate
                                        
                                        mapView.addAnnotation(annotation)
                                        nameText.text = annotationTitle
                                        noteText.text = annotationSubtitle
                                        
                                        locationManager.stopUpdatingLocation()
                                        
                                        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true) //kullanıcı hareket ettikçe yeni konumunu alma pinler olduğu gibi kalsın
                                    }
                                }
                            }
                        }
                    }
                }
                
            }catch {
                print("error")
            }
        } else {
            //Add New Data
            print("else error")
        }
    }
    
    @objc func choseLocation (gestureRecognizer: UILongPressGestureRecognizer) {
        
        //tıklanılan yerin koordinatlarını alıp oraya pin koymam lazım
        
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView) //nereye dokunulduysa al
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView) //koordinatları çevir
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            let annotation = MKPointAnnotation() //pin oluşturuyoruz
            annotation.coordinate = touchedCoordinates
            annotation.title = nameText.text
            annotation.subtitle = noteText.text
            self.mapView.addAnnotation(annotation)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //konumu aldım ne yapacağım
        //konum güncellendikçe onları bana dizi içerisinde veriyor
        if selectedTitle == "" { // seçilen yok ise beni olduğum yere götür viewloaddaki if için yazıldı
        let location = CLLocationCoordinate2D (latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude) //enlem ve boylamlardan oluşan bir konum çizmemiz için gereken objeyi veriyor.
        //eğer enlem ve boylamı biliyorsak ellede girebiliriz.
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) //haritada  gösterebilmek için zoom seviyesi
        let region = MKCoordinateRegion(center: location, span: span)
        //center : merkez neresi olsun span : ne kadar zoomlayayım
        mapView.setRegion(region, animated: true)
        } else {}
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) { //yeni değerler atayıp kaydetme
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(noteText.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        navigationController?.popViewController(animated: true) //kaydettiğim an beni ilk sayfaya göndersin
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { //annotation2u özelleştirme
        
        if annotation is MKUserLocation { //kullanıcının yerini gösteren annotation ama
            return nil   //pinle gösterme
        }
        
        
        let reuseID = "myAnnotation"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID) //annotationu tanıttık
            pinView?.canShowCallout = true //baloncukla beraber extra bilgi gösterebildiğimiz yer
            pinView?.tintColor = UIColor.black //siyah olsun
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure) //detay göstereceğim bir buton
            pinView?.rightCalloutAccessoryView = button //sağ tarafında bu butonu göster
            
        } else {
            pinView?.annotation = annotation // eğer daha önc eoluşturulduysa pinim bana daha önce verilen pin
        }
        
        return pinView
    
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //pinin yanındaki i'ye tıklandı - ne olacak?
        
        if selectedTitle != "" { //eğer seçili bir şey varsa yani enlem ve boylm varsa
            
            let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                //closure
                //işlem yapıyorum dönüş olacak ya hata olacak ya placemarks verecek, placemarksları alarak navigasyonu başlatacağım
                
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.annotationTitle
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            } //koordinatlar ve yerler arasında bağlantı kurmamızı sağlayan bir sınıf , gitmek istediğim yeri gösteren bir obje olacak, o obje ile naqvigation başlayacak
            
        }
    }
    
    
}

