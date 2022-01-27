//
//  TopRatedMoviesCollectionViewCell.swift
//  MoviesAndTVShowsApplication
//
//  Created by Yasemin TOK on 9.11.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var moviesTitle: UILabel!
    @IBOutlet weak var moviesImageView: UIImageView!
 
    func SaveMovies(model: Result?) {

        let imagePath = "\(Path.ImagePath.BASE_URL)\(Path.ImagePath.FILE_SIZE)\(model?.posterPath ?? "")"
        
        moviesTitle.text = model?.title
        moviesImageView.af.setImage(withURL: URL(string: imagePath)!)
    }
}
