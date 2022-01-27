//
//  MoviesDetailsViewModel.swift
//  MoviesAndTVShowsApplication
//
//  Created by Yasemin TOK on 28.12.2021.
//

import Foundation

protocol MoviesDetailsProtocol {
    
    var moviesDetails: MoviesDetails? {get set}
    var castDetails: [MoviesCast]? {get set}
    var services: ServicesProtocol {get}
    var moviesDetailsOutput: MoviesDetailsOutput? {get}
    func setDelegateMoviesDetails(output: MoviesDetailsOutput)
    func allMoviesDetails(id: Int)
}

final class MoviesDetailsViewModel: MoviesDetailsProtocol {
    
    // - MARK: Properties
    
    var moviesDetails: MoviesDetails?
    var castDetails: [MoviesCast]? = []
    var services: ServicesProtocol
    var moviesDetailsOutput: MoviesDetailsOutput?
    
    // - MARK: init
    
    init() {
        services = Services()
    }
    
    func setDelegateMoviesDetails(output: MoviesDetailsOutput) {
        moviesDetailsOutput = output
    }
    
    func allMoviesDetails(id: Int) {
        services.fetchAllMoviesDetails(movieID: id) { [weak self] (response) in
            self?.moviesDetails = response
            self?.moviesDetailsOutput?.moviesDetails(model: self?.moviesDetails)
        } onError: { error in
            print(error)
        }
        
        services.fetchAllCastDetails(movieID: id) { [weak self] (response) in
            self?.castDetails = response ?? []
            self?.moviesDetailsOutput?.castDetails(values: self?.castDetails ?? [])
        } onError: { error in
            print(error)
        }
    }
}
