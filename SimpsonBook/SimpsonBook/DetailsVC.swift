//
//  DetailsVC.swift
//  SimpsonBook
//
//  Created by Yasemin TOK on 19.08.2021.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!

    var selectedSimpson : Simpson? //opsiyonel yaptık
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedSimpson?.name
        jobLabel.text = selectedSimpson?.job
        imageView.image = selectedSimpson?.image
        
    }
    

}
