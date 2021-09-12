//
//  Musicians.swift
//  MusicianClass
//
//  Created by Yasemin TOK on 18.08.2021.
//

import Foundation

enum MusicianType { //kendi özellik listemi oluşturdum, seçenekleri ben belirledim. kategorilediğimiz bir yapı
    case LeadGuitar
    case Vocalist
    case Drummer
    case Bassist
}

class Musicians {
    
    
    //property
    var name : String
    var age : Int
    var instrument : String
    var type : MusicianType
    
    
    //initializer (constructor)
    init(nameInit : String , ageInit : Int, instrumentInit : String, typeInit : MusicianType) { //bu kod buluğundakiler bu sınıftan bir obje oluşturulduğunda yapılacak
        
        name = nameInit
        age = ageInit
        instrument = instrumentInit
        type = typeInit
    }
    
    func sing() {
        print("nothing else matters")
        
    }
    
    
}
