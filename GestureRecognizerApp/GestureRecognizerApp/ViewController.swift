//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by Yasemin TOK on 17.08.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pictureLabel: UILabel!
    
    var isPic1 = true //functa oluşturamayız çünkü mantık hatası oluyor.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true //resme tıklanabilinsin
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
       //görsele tıklandığında functa ne varsa o çalışacak
        
        imageView.addGestureRecognizer(gestureRecognizer) //imageviewe yazdığımız tanıma özelliğini ekledik
    }
    
    @objc func changePic() {
        
        
        if isPic1 == true {
     
            imageView.image = UIImage (named: "picture2")
            pictureLabel.text = "Pic 2"
            isPic1 = false
        } else {
            imageView.image = UIImage (named: "picture1")
            pictureLabel.text = "Pic 1"
            isPic1 = true
            
        }
    }
    
}

