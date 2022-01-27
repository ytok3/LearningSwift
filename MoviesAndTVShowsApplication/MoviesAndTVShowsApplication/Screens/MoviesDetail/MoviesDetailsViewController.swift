//
//  MoviesDetailsViewController.swift
//  MoviesAndTVShowsApplication
//
//  Created by Yasemin TOK on 20.12.2021.
//

import UIKit
import Alamofire
import AlamofireImage

protocol MoviesDetailsOutput {

    func moviesDetails(model: MoviesDetails?)
    func castDetails(values: [MoviesCast])
}

class MoviesDetailsViewController: UIViewController {
    
    @IBOutlet weak var moviesCastTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movieId: Int?
    lazy var moviesDetailsViewModel: MoviesDetailsProtocol = MoviesDetailsViewModel()
    lazy var cast: [MoviesCast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesDetailsViewModel.setDelegateMoviesDetails(output: self)
        moviesDetailsViewModel.allMoviesDetails(id: movieId ?? 0)
        
        moviesCastTableView.delegate = self
        moviesCastTableView.dataSource = self
        moviesCastTableView.rowHeight = 140
        
    }
}

extension MoviesDetailsViewController: MoviesDetailsOutput {
    
    func moviesDetails(model: MoviesDetails?) {
        
        let imagePath = "\(Path.ImagePath.BASE_URL)\(Path.ImagePath.FILE_SIZE)\(model?.posterPath ?? "")"
        
        titleLabel.text = model?.title
        originalTitleLabel.text = model?.originalTitle
        originalLanguageLabel.text = model?.originalLanguage
        releaseDateLabel.text = model?.releaseDate
        taglineLabel.text = model?.tagline
        posterImageView.af.setImage(withURL: URL(string: imagePath)!)
    }
    
    func castDetails(values: [MoviesCast]) {
        cast = values
        moviesCastTableView.reloadData()
    }
}

extension MoviesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let castCell = tableView.dequeueReusableCell(withIdentifier: Path.Identifier.MoviesCastDetailsCell, for: indexPath) as? CastDetailsTableViewCell else {
            return UITableViewCell()
        }
        castCell.SaveModelCastDetails(model: cast[indexPath.row])
        return castCell
    }
}

