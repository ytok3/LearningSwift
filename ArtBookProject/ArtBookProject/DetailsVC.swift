//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Yasemin TOK on 19.08.2021.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPainting != "" {
            
            saveButton.isHidden = true
            
            //CoreData
            //filtreleme işlemleri
            
            //let stringUUID = chosenPaintingId!.uuidString
            //print(stringUUID)    uuidyi stringe çevirme
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idStirng = chosenPaintingId?.uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idStirng!) //id ile arama yapıyoruz
            //bir koşul yazacağım ve yazılan koşula göre bana veri getirecek
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            } catch {
                print("error")
            }
        } else {
            
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }

        //Recognizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer) //klavye  kapansın diye ekrana tıklama özelliği
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer) // resme dokunulsun diye
        
    }
    
    @objc func hideKeyboard () { // ekrana tıklanınca klavyeyi kapatma func
        view.endEditing(true) //VC içindeki işlemlerim bitti diyor
    }
    
    @objc func selectImage () {
        
        let picker = UIImagePickerController() //kullanıcıdan foto, video vs almak için kullanılır.
        picker.delegate = self
        picker.sourceType = .photoLibrary // bahsedilen öğelere nereden ulaşacak? telefonun kütüphanesinden
        picker.allowsEditing = true // kullanıcı eklediği fotoğrafı değiştirerek ekleyebilir. zoom, cut vs
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { //ekleme ile işim bitince ne yapayım
        
        imageView.image = info[.originalImage] as? UIImage //kullanıcının kullandığı görseli image olarak kayde.t ve imageviewe ata
        saveButton.isEnabled = true // save butonunu görünür yap
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //projenin içindeki AppDelegate'i değişken olarak atadım çünkü onun içindeki DataCore'a ulaşmam lazım segue.destinationdaki gibi
        let context = appDelegate.persistentContainer.viewContext //AppDelegate içindeki suporting funclarına ulaşabildim
        let newPainting =  NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        //forEntityName : artbookproject'te oluşturduğumuz veritabanı adı
        //into : oluşturduğumuz context
        
        //Attribute
        
        newPainting.setValue(nameText.text!, forKey: "name") //artbookproject'teki değerler
        newPainting.setValue(artistText.text, forKey: "artist")
        
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5) //image dataya çevrildi. - ne kadarını sıkıştırayım
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save() //coredata'ya veriyi kaydetmemize olanak sağlıyor
            print("success")
            
        } catch {
            print("error")
        }
      
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil) //diğer VClere mesaj göndermemizi sağlıyor mesela newData diye bir şey belirledim  diğer VClerden biri bunu alırsa istenen kod bloğu çalıştırılacak
        
        self.navigationController?.popViewController(animated: true) //bir önceki VC'ye gidiyor
        
    }
}
