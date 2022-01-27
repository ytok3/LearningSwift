//
//  MusicianStruct.swift
//  AdvancedSwiftProject
//
//  Created by Yasemin TOK on 13.09.2021.
//

import Foundation

// init işlemine gerek kalmadı
struct MusicianStruct {
    
    var name : String
    var age : Int
    var instrument : String
    
    // eğer bir func altında ilgili özellik değiştirilecekse mutating kullanılır(struct için)
    mutating func happyBirthday() {
        self.age += 1
    }
}
