//
//  MoviesViewModel.swift
//  MoviesAndTVShowsApplication
//
//  Created by Yasemin TOK on 24.01.2022.
//

import Foundation

protocol MoviesViewModelProtocol {
    
    var movies: [Result]? {get set}
    var services: ServicesProtocol {get}
    var moviesOutput: MoviesOutput? {get}
    func setDelegateMovies(output: MoviesOutput)
    func allMovies()
}

final class MoviesViewModel: MoviesViewModelProtocol {
    
    // - MARK: Properties
    
    var movies: [Result]? = []
    var services: ServicesProtocol
    var moviesOutput: MoviesOutput?
    
    // - MARK: init
    
    init() {
        services = Services()
    }
    
    func setDelegateMovies(output: MoviesOutput) {
        moviesOutput = output
    }
    
    func allMovies() {
        services.topRatedMovies { [weak self] (response) in
            self?.movies = response ?? []
            self?.moviesOutput?.saveTRMovies(values: self?.movies ?? [])
        } onError: { error in
            print(error)
        }

        services.nowPlayingMovies { [weak self] (response) in
            self?.movies = response ?? []
            self?.moviesOutput?.saveNPMovies(values: self?.movies ?? [])
        } onError: { error in
            print(error)
        }
        
        services.popularMovies { [weak self] (response) in
            self?.movies = response ?? []
            self?.moviesOutput?.savePMovies(values: self?.movies ?? [])
        } onError: { error in
            print(error)
        }
    }
}
