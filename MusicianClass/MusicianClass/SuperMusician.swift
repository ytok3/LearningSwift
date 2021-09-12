//
//  SuperMusician.swift
//  MusicianClass
//
//  Created by Yasemin TOK on 18.08.2021.
//

import Foundation //musicians sınıfındaki tüm özellikleri kullanıp  üzerine ekleme yapmak istiyorum yani miras alma

class SuperMusician : Musicians {
    
    func sing2() {
        print("enter night")
    }
    
    override func sing() { //hazır yapının üzerine yazdık. sing funcunı bu sınıf için değiştirdik.
        super.sing()
        print("exit light")
    }
    
}



