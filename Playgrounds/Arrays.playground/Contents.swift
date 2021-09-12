import UIKit

var myFavouriteMovies = ["Inception", "Spiderman", "La La Land", 27] as [Any] //any dizisi olması içine her türden değer yazılabileceğini gösterir.


myFavouriteMovies[0] //any dizisi olduğu için işlemler gelmez


var myStringArray = ["Uno", "Dos", "Tres", "Sev"]

myStringArray[0].uppercased()

myStringArray.count

myStringArray[myStringArray.count - 1]

myStringArray.last

myStringArray.sort()

myStringArray[0] = "Yun"

print(myStringArray)

var mySet : Set = [1, 2, 3, 4, 5, 1, 2, 3]

var myStringSet : Set = ["a", "b", "a"]

var myInternetArray = [1,2,3,4,5,6,1,2,3,4]
var myInternetSet = Set(myInternetArray)

print(myInternetArray)
print(myInternetSet)


var mySet1 : Set = [1,2,3]
var mySet2 : Set = [3,4,5]

var mySet3 = mySet1.union(mySet2) //union birleştir demek

print(mySet3)


//dictionary

var myFavoriteWriters = ["Tutunamayanlar" : "Oğuz Atay", "1984" : "George Orwell", "Gurur ve Önyargı" : "Jane Austen"]

myFavoriteWriters["Tutunamayanlar"]
myFavoriteWriters["1984"]

myFavoriteWriters["Tutunamayanlar"] = "Oğuz ATAY"

myFavoriteWriters["Od"] = "İskender Pala"

print(myFavoriteWriters)


var myDictionary = ["Run" : 100, "Swim" : 200, "Basketball" : 300]
myDictionary["Run"]
