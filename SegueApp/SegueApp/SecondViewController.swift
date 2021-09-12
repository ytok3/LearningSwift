//
//  SecondViewController.swift
//  SegueApp
//
//  Created by Yasemin TOK on 16.08.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var secondMyLabel: UILabel!
    
    @IBOutlet weak var secondNameLabel: UILabel!
    
    var secondName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        secondNameLabel.text = secondName
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
