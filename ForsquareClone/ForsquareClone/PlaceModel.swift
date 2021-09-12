//
//  PlaceModel.swift
//  ForsquareClone
//
//  Created by Yasemin TOK on 5.09.2021.
//

import Foundation
import UIKit

//Singleton bir sınıftan bir obje oluşturarak sadece onu kullanır ve o objeyi erişim noktası yaparak diğer kod blokları için kullanır.


class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init() {} //başka bir yerden erişim yapılamaz
}
