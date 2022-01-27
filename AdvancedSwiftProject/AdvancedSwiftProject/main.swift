//
//  main.swift
//  AdvancedSwiftProject
//
//  Created by Yasemin TOK on 13.09.2021.
//

import Foundation

let classJames = MusicianClass(nameInput: "James", ageInput: 50, instrumentInput: "Guitar")
//print(classJames.age)

var structJames = MusicianStruct(name: "James", age: 50, instrument: "Guitar")
//print(structJames.age)

// MARK: Immutable Struct

classJames.age = 51
//print(classJames.age)

// struct içindeki değerler değiştirilemez olsun istiyorsak let, değiştirilebilir ise  var
structJames.age = 51
//print(structJames.age)

// MARK: Reference vs. Value

let copyOfClassJames = classJames
var copyOfStructJames = structJames

//print(copyOfClassJames.age)
//print(copyOfStructJames.age)

copyOfClassJames.age = 52
copyOfStructJames.age = 52

//print(copyOfClassJames.age)
//print(copyOfStructJames.age)

//print(classJames.age)
//print(structJames.age)

// MARK: Brief

// References Types -> Class
// Copy -> Same Object new reference -> 1 object + 2 References
// class kopyalansa bile aynı obje üzerinden işlem yaptığı için ana sınıftaki değerde değişiyor

// Values Types -> Struct
// Copy -> new object -> 2 objects
// struct kopyalandığında yeni bir obje oluşturuyor ve onun üzerinden işlem yapıyor yani ana structa bir şey olmuyor.

// MARK: Function vs. Mutating Function

/*print(classJames.age)
classJames.happyBirthday()
print(classJames.age)

print(structJames.age)
structJames.happyBirthday()
print(structJames.age)*/

// MARK: Tuple

// istediğim değerleri bir arada tutup kullanmak için kullanılan koleksiyondur. Koordinatlar vs. (string vs de kullanabiliriz)
let myTuple = (1, 3)
print(myTuple.0)

// let ile tanımlarsak değişiklik yapılamaz, var ile tanımlanırsa değişiklik yapılabilir
var myTuple2 = (1, 3, 5)
myTuple2.2 = 10
print(myTuple2.2)

let myTuple3 = (10,[10, 20, 30])
// 20yi yazdırdık
print(myTuple3.1[1])

// MARK: Guard Let vs. If Let

let myNumber = "5"

func convertToIntegerGuard (stringInput: String) -> Int {
    guard let myInteger = Int(stringInput) else {return 0}
    return myInteger
}

func convertToIntegerIf (stringInput: String) -> Int {
    if let myInteger = Int(stringInput) {
        return myInteger
    } else {
        return 0
    }
}

print(convertToIntegerIf(stringInput: myNumber))
print(convertToIntegerGuard(stringInput: myNumber))

// MARK: Switch

let myNum = 11

let myRemainder = myNum % 3
print(myRemainder)

switch myRemainder {
case 1:
    print("it's 1")
case 2:
    print("it's 2")
case 3:
    print("it's 3")
default:
    print("none of the above")
}

// MARK: Breakpoint
// hata arama

