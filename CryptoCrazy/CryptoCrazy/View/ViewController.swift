//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Yasemin TOK on 26.09.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListViewModel : CryptoListViewModel!
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.colorArray = [
            UIColor(red: 150/255, green: 200/255, blue: 100/255, alpha: 1.5),
            UIColor(red: 100/255, green: 50/255, blue: 200/255, alpha: 1.5),
            UIColor(red: 125/255, green: 150/255, blue: 50/255, alpha: 1.5),
            UIColor(red: 50/255, green: 75/255, blue: 200/255, alpha: 1.5),
            UIColor(red: 100/255, green: 200/255, blue: 125/255, alpha: 1.5),
            UIColor(red: 200/255, green: 200/255, blue: 100/255, alpha: 1.5),
            UIColor(red: 25/255, green: 20/255, blue: 100/255, alpha: 1.5),
            UIColor(red: 20/255, green: 100/255, blue: 50/255, alpha: 1.5),
            UIColor(red: 10/255, green: 225/255, blue: 125/255, alpha: 1.5),
            UIColor(red: 150/255, green: 20/255, blue: 10/255, alpha: 1.5),]
        
        getData()
    }
    
    func getData() {
        let url = URL(string : "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { cryptos in
            if let cryptos = cryptos {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.currencyText.text = cryptoViewModel.name
        cell.priceText.text = cryptoViewModel.price
        cell.backgroundColor = self.colorArray[indexPath.row % 10]
        return cell
    }


}

