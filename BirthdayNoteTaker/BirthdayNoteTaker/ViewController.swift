//
//  ViewController.swift
//  BirthdayNoteTaker
//
//  Created by Yasemin TOK on 16.08.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var birthdayText: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
       // nameLabel.text = storedName as! String //as! storedName'i kesin String olarak kaydet as? ise yapabilirsen String olarak kaydet demek
        
        if let nameString = storedName as? String { //Any'yi String'e çevirme
            nameLabel.text = nameString
        }
        if let birthdayString = storedBirthday as? String {
            birthdayLabel.text = birthdayString
        }
        
    }


    @IBAction func saveButton(_ sender: Any) {
        
        //let nameT = nameText.text
       // nameLabel.text = nameT
        
        //nameLabel.text = "Name: \(nameText.text!)" -> kodun arasında String yazdırma \ ile
        
        UserDefaults.standard.set(nameText.text!, forKey: "name")
        UserDefaults.standard.set(birthdayText.text!, forKey: "birthday")
        
        nameLabel.text = nameText.text!
        birthdayLabel.text = birthdayText.text!
        
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if (storedName as? String) != nil { //stringe çevrilmiş hali eğer boş değilse sil
        
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name: "
        }
        
        if (storedBirthday as? String) != nil {
        
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text = "Birthday: "
        
        }
        
    }
}

