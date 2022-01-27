//
//  CryptoCurrency.swift
//  CryptoCrazy
//
//  Created by Yasemin TOK on 26.09.2021.
//

import Foundation

// bir veriyi düzgün bir formatta çekiyorsak kendisi direkt alsın diye Decodable yapabiliriz.

struct CryptoCurrency : Decodable {
    let currency : String
    let price : String
}

