//
//  ViewController.swift
//  ObjectWithCode
//
//  Created by Yasemin TOK on 15.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var myLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width //ekran ne olursa olsun genişliğini ve yüksekliğini al
        let height = view.frame.size.height // ona göre her ekranda çalışabilecek
        
        // let myLabel = UILabel() //label oluşturduk
        myLabel.text = "Text Label"
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: width * 0.35, y: height * 0.4, width: 100, height: 100) // frame label görünsün diye var
        view.addSubview(myLabel) // ekrana labeli gönderiyoruz
        
        
        let myButton = UIButton()
        myButton.setTitle("My Button", for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        myButton.frame = CGRect(x: width * 0.3, y: height * 0.5, width: 150, height: 100)
        view.addSubview(myButton)
        
        myButton.addTarget(self, action: #selector(myAction), for: .touchUpInside) //kullaınıcı butona tıklayınca ne olacağını belirten bir target yazdık.

        //self = viewcontroller içerisinde çalışacağını gösterdi
        //#selector ve @objc kalıp ve butonun yapacağı iş için bir func yazılmalı
        //for butona ne yapıldığında çalışacak, burada içine tıklandığında
        
    }
    
    @objc func myAction() {
       // print("tapped")
        myLabel.text = "Tapped"
        //buton için func yazdık
    }


}

