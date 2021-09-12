//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Yasemin TOK on 14.08.2021.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var firstNumber: UITextField!
    
    @IBOutlet weak var secondNumber: UITextField!
    
    @IBOutlet weak var conclusionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func sumButton(_ sender: Any) {
        
        if let firstN = Int(firstNumber.text!) { // ! değer geliceğinden emin
            if let secondN = Int(secondNumber.text!) {
                let result = firstN + secondN
                conclusionLabel.text = String(result)
            }
        }
    }
    
    @IBAction func subButton(_ sender: Any) {
        
        if let firstN = Int(firstNumber.text!) {
            if let secondN = Int(secondNumber.text!) {
                let result = firstN - secondN
                conclusionLabel.text = String(result)
            }
        }
    }
    @IBAction func mulButton(_ sender: Any) {
        
        if let firstN = Int(firstNumber.text!) {
            if let secondN = Int(secondNumber.text!) {
                let result = firstN * secondN
                conclusionLabel.text = String(result)
            }
        }
    }
    
    @IBAction func divButton(_ sender: Any) {
        
        if let firstN = Int(firstNumber.text!) {
            if let secondN = Int(secondNumber.text!) {
                let result = firstN / secondN
                conclusionLabel.text = String(result)
            }
        }
    }
    
}

