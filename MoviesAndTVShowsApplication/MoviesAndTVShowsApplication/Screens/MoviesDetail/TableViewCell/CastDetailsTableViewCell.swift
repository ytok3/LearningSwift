//
//  CastDetailsTableViewCell.swift
//  MoviesAndTVShowsApplication
//
//  Created by Yasemin TOK on 9.01.2022.
//

import UIKit
import Alamofire
import AlamofireImage

protocol CastDetailsCell {
    
    func SaveModelCastDetails(model: MoviesCast)
}

class CastDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    func SaveModelCastDetails(model: MoviesCast?) {
        
        let imagePath = "\(Path.ImagePath.BASE_URL)\(Path.ImagePath.FILE_SIZE)\(model?.profilePath ?? "")"
        
        departmentLabel.text = model?.knownForDepartment
        nameLabel.text = model?.name
        characterLabel.text = model?.character
        profileImageView.af.setImage(withURL: URL(string: imagePath)!)
    }
}
