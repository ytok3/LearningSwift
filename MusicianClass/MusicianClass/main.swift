//
//  main.swift
//  MusicianClass
//
//  Created by Yasemin TOK on 18.08.2021.
//

import Foundation

let james = Musicians(nameInit: "James", ageInit: 50, instrumentInit: "Guitar", typeInit: .Vocalist) //musicians sınıfından obje oluşturduk

print(james.age)
print(james.type)
james.sing()
//james sing2 funcunı kullanamaz çünkü o Musicians sınıfından ama kirk SuperMusician sınıfından oluşturuldu.

let kirk = SuperMusician(nameInit: "Kirk", ageInit: 45, instrumentInit: "Guitar", typeInit: .LeadGuitar)
kirk.sing()
//kirk.sing2()




