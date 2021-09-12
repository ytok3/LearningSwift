//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Yasemin TOK on 11.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func changeButtonClicked(_ sender: Any) {
        
        imageView.image = UIImage(named: "picture2")
        
    }
    
}

