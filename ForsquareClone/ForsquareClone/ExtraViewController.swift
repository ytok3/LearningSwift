//
//  ExtraViewController.swift
//  ForsquareClone
//
//  Created by Yasemin TOK on 2.09.2021.
//

import UIKit

class ExtraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PARSE
        
        //INSERT VALUE
        
       /* let parseObject = PFObject(className: "Fruits") //sınıf oluşturdum
        parseObject["name"] = "Banana" //objenin isimini verdim. parseobject dictionary gibi al
        //isim değerini verdiğimde apple baluesini verecek
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in //kaydedelim ve kullanıcı işlem yaparsa bilelim
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                print("success")
            }
        }
        */
        
        //GET VALUE
        
       /* let query = PFQuery(className: "Fruits")
        //query.whereKey("name", equalTo: "Apple") //şart koydum. ismi apple olanları getir
        //query.whereKey("calories", greaterThan: 120)
        query.findObjectsInBackground { objects, error in //veri çekiyorum
            //neden [PFObject]? : neden opsiyonel çünkü dizi çok olabilir neden dizi çünkü birden fazla obje olacak neden PF çünkü onunla çalışıyorum //objects yazık yerine
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                print(objects)
            }
        } */

    }


}
