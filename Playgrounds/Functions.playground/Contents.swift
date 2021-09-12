import UIKit

func myFunction (){
    
    print("My Function") //sadece yazdım çağırmadım o yüzden yazmaz
}

myFunction() //çağırdım


func sumFunction(x : Int, y : Int) -> Int { //x ve y alınan değerler -> sonrası ise döndürülecek değer
    
    //print(x + y) returnden önce
    
    return x + y
}

let myFunctionVariable = sumFunction(x: 5, y: 10)

print(myFunctionVariable)


func logicFunction (a : Int, b : Int) -> Bool {
    
    if a > b {
        return true
    } else {
    return false
    }
    
}

logicFunction(a: 10, b: 5)

