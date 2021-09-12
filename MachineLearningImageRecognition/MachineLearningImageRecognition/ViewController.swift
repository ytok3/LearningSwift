//
//  ViewController.swift
//  MachineLearningImageRecognition
//
//  Created by Yasemin TOK on 6.09.2021.
//

import UIKit
import CoreML
import Vision //coreml ile beraber imagerecognition için kullanılır

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var choosenImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeClicked(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //kullanıcı resi seçtikten sonra ne olsun
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    
        if let ciImage = CIImage(image: imageView.image!) { //coremlde UIImage yerime CIImage  kullanılıyor o yüzden dönüştürüyoruz.
            choosenImage =  ciImage
            
        }
        
        
        recognizeImage(image: choosenImage)
        
        
        
    }
    
    func recognizeImage(image : CIImage) { //artık CIImage'ı tanıyoruz
        
        // 1) Request
        // 2) Handler
        
        resultsLabel.text = "Finding..."
        
        let config = MLModelConfiguration()
        if let model = try? VNCoreMLModel(for: MobileNetV2(configuration: config).model) {
            
            let modelRequest = VNCoreMLRequest(model: model) { request, error in
                if error != nil {
                    print(error?.localizedDescription ?? "Error!!")
                } else {
                    if let results = request.results as? [VNClassificationObservation] { //image eşleşmeleri sonucunda benzerlerini bulup bir diziye atıyor ve gözlem dizisini gösteriyor
                        if results.count > 0 {
                            let topResult = results.first //ilk seçeneği al
                   
                            //requestin çalışacağı yer handler
                            DispatchQueue.main.async {
                                //yüzde kaç ihtimalle bu işlem yapılıyor
                                
                                let confidenceLevel = (topResult?.confidence ?? 0)  * 100
                                
                                let rounded = Int (confidenceLevel * 100) / 100
                                
                                self.resultsLabel.text = "\(rounded)% it's \(topResult!.identifier)"
                            }
                        }
                    }
                }
            }
            
            //handler
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([modelRequest])
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    //async ile sync arasında fark
    //eğer sync olursa sıradaki işlemi alır ve yapana kadar bekler yani sistem veya  uygulama kitlenir ama async olursa sıraya alır ama bitene kadar beklemez
    //dispatchqueue
    //main ve global arasında ne fark var
    //global olması öncelik vermesi, yine arka planda çalıştırır ama büyük öncelik verir. her zaman kullanılmaz, nadir kullanılır ama bir işlemi hızlı ve async olarak yapmak istersek kullanırız
    //kod önceliği benim belirlememi sevmez ama öncelik gerekiyorsa kullanılır.
    
}

