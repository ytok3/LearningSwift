import UIKit

var myName : String?

myName?.uppercased() //? belki değer olur belki olmaz değer girilmezse işlem yapma
                     // nil boş demek
                     //! kesinlikle bir değer olacak

var myAge = "7"

//var myInteger = Int(myAge) * 5    bu hali hata verir çünkü her girilen String Integera çevrilemez

var myInteger = (Int(myAge) ?? 6) * 5


if let myNumber = Int(myAge) {
    
    print(myNumber * 5)
} else {
    
    print("Wrong input")
}
