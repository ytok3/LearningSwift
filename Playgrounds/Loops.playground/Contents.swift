import UIKit

var myNumber = 1

myNumber = myNumber + 1

myNumber += 1

myNumber


var number = 0

while number <= 10 {
    
    //print(number)
    
    number += 1
}


var characterAlive = true

while characterAlive == true {
    
    //print("Character Alive")
    characterAlive = false
}


var myFruitArray = ["Banana", "Apple", "Orange"]

for fruit in myFruitArray {  //dizideki elemanları fruit değişkenine tek tek ata
    
    print(fruit)
}

var myNumbers = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

for numbers in myNumbers {
    
    print(numbers / 5)
}


for myNewInteger in 1 ... 5 {
    
    print(myNewInteger)
}
