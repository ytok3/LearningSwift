//
//  ViewController.swift
//  SegueApp
//
//  Created by Yasemin TOK on 16.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var userName = ""
    
    override func viewDidLoad() { //2.sayfadan geri gelinince tekrar çalışmıyor.
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Lifecycle
        
        print("viewDidLoad function called")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        print("viewDisDisappear function called")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        print("viewWillDisappear function called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("viewWillAppear function called")
        nameTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("viewDidAppear function called")
        
        
    }


    @IBAction func nextButtonClicked(_ sender: Any) {
        
        userName = nameTextField.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //segue olmadan önce yapılacaklar yazılıyor. iki sayfadaki nameleri eşitlemek için kullanıyoruz.
        
        if segue.identifier == "toSecondVC" { //seguenin idsi kontrol ediliyor, benim belirlediğimse çalıştır.
            
            let destinationVC = segue.destination as! SecondViewController //seguenin hedefi belirlendi, as ile hangisini istediğimizi yazdık.
            destinationVC.secondName = userName  //artık diğer VCye erişebiliyorum.
            
            
        }
        
    }
}

