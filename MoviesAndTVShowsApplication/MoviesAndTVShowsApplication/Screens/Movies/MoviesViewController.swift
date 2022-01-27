//
//  MoviesViewController.swift
//  MoviesAndTVShowsApplication
//
//  Created by Yasemin TOK on 9.11.2021.
//

import UIKit

protocol MoviesOutput {
    
    func saveTRMovies(values: [Result])
    func saveNPMovies(values: [Result])
    func savePMovies(values: [Result])
}

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var topRatedMoviesCollectionView: UICollectionView!
    @IBOutlet weak var topRatedMoviesHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nowPlayingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingMoviesHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var popularmoviesHeightConstraint: NSLayoutConstraint!
    
    private lazy var resultsTopRated: [Result] = []
    private lazy var resultsNowPlaying: [Result] = []
    private lazy var resultsPopular: [Result] = []
    
    lazy var moviesViewModel: MoviesViewModelProtocol = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRatedMoviesCollectionView.delegate = self
        topRatedMoviesCollectionView.dataSource = self
        
        nowPlayingMoviesCollectionView.delegate = self
        nowPlayingMoviesCollectionView.dataSource = self
        
        popularMoviesCollectionView.delegate = self
        popularMoviesCollectionView.dataSource = self
        
        moviesViewModel.setDelegateMovies(output: self)
        moviesViewModel.allMovies()
    }
    
    // MARK: Constant
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setHeightOfCollectionViews()
    }
    
    func setHeightOfCollectionViews() {
        
        let width = topRatedMoviesCollectionView.bounds.width
        let height = width / 1.5
        topRatedMoviesHeightConstraint.constant = height
        nowPlayingMoviesHeightConstraint.constant = height
        popularmoviesHeightConstraint.constant = height
    }
}

// MARK: Cells

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: numberOfItems
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        
        case topRatedMoviesCollectionView:
            return resultsTopRated.count
        case nowPlayingMoviesCollectionView:
            return resultsNowPlaying.count
        case popularMoviesCollectionView:
            return resultsPopular.count
        default:
            return 1
        }
    }
    
    // MARK: cellForItem
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        
        case topRatedMoviesCollectionView:
            guard let topRatedMoviesCell = topRatedMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Path.Identifier.MoviesCell, for: indexPath) as? MoviesCollectionViewCell else {
                return UICollectionViewCell()
            }
            topRatedMoviesCell.SaveMovies(model: resultsTopRated[indexPath.item])
            return topRatedMoviesCell
        case nowPlayingMoviesCollectionView:
            guard let nowPlayingMoviesCell = nowPlayingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Path.Identifier.MoviesCell, for: indexPath) as? MoviesCollectionViewCell else {
                return UICollectionViewCell()
            }
            nowPlayingMoviesCell.SaveMovies(model: resultsNowPlaying[indexPath.item])
            return nowPlayingMoviesCell
        case popularMoviesCollectionView:
            guard let popularMoviesCell = popularMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Path.Identifier.MoviesCell, for: indexPath) as? MoviesCollectionViewCell else {
                return UICollectionViewCell()
            }
            popularMoviesCell.SaveMovies(model: resultsPopular[indexPath.item])
            return popularMoviesCell
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: sizeForItem
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let columns: CGFloat = 2
            let collectionViewWidth = collectionView.bounds.width
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
            let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
            let width: CGFloat = floor(adjustedWidth / columns)
            let height: CGFloat = width * 3
            
            return CGSize(width: width, height: height)
    }
    
    // MARK: didSelectItem
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        
        case topRatedMoviesCollectionView:
            let viewController = storyboard?.instantiateViewController(withIdentifier: Path.Identifier.DetailsVC) as! MoviesDetailsViewController
            viewController.movieId = resultsTopRated[indexPath.row].id ?? 0
            navigationController?.pushViewController(viewController, animated: true)
        case topRatedMoviesCollectionView:
            let viewController = storyboard?.instantiateViewController(withIdentifier: Path.Identifier.DetailsVC) as! MoviesDetailsViewController
            viewController.movieId = resultsNowPlaying[indexPath.row].id ?? 0
            navigationController?.pushViewController(viewController, animated: true)
        case topRatedMoviesCollectionView:
            let viewController = storyboard?.instantiateViewController(withIdentifier: Path.Identifier.DetailsVC) as! MoviesDetailsViewController
            viewController.movieId = resultsPopular[indexPath.row].id
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}

// MARK: Output

extension MoviesViewController: MoviesOutput {
    func saveTRMovies(values: [Result]) {
        resultsTopRated = values
        topRatedMoviesCollectionView.reloadData()
    }
    
    func saveNPMovies(values: [Result]) {
        resultsNowPlaying = values
        nowPlayingMoviesCollectionView.reloadData()
    }
    
    func savePMovies(values: [Result]) {
        resultsPopular = values
        popularMoviesCollectionView.reloadData()
    }
}
