//
//  CryptoViewModel.swift
//  CryptoCrazy
//
//  Created by Yasemin TOK on 26.09.2021.
//

import Foundation

struct CryptoListViewModel {
    let cryptoCurrencyList : [CryptoCurrency]
    
    func numberOfRowsInSection() -> Int {
        return self.cryptoCurrencyList.count
    }
    func cryptoAtIndex(_ index : Int) -> CryptoViewModel {
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }
}

// oluşturulmuş sınıf veya yapıya ekleme yapmayı sağlar

/*extension CryptoListViewModel {
    
}*/

struct CryptoViewModel {
    let cryptoCurrency : CryptoCurrency
    
    var name : String {
        return self.cryptoCurrency.currency
    }
    var price : String {
        return self.cryptoCurrency.price
    }
  
}

/*extension CryptoViewModel {
    var name : String {
        return self.cryptoCurrency.currency
    }
    var price : String {
        return self.cryptoCurrency.price
    }
}*/
