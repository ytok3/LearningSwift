//
//  MusicianClass.swift
//  AdvancedSwiftProject
//
//  Created by Yasemin TOK on 13.09.2021.
//

import Foundation

class MusicianClass {
    
    var name : String
    var age : Int
    var instrument : String
    
    // bu sınıftan bir obje oluşturulduğunda çağrılacak ilk func, değerleri alınan inputa göre eşitliyoruz.
    init(nameInput : String, ageInput : Int, instrumentInput : String) {
        self.name = nameInput
        self.age = ageInput
        self.instrument = instrumentInput
    }
    
    func happyBirthday() {
        self.age += 1
    }
}
