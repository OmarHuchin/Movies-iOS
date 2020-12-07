//
//  Interactor.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Promises
class MovieInteractor: MoviePresenterToInteractorProtocol{
    var movies: [Movie] = [Movie]()
    var currentPage: Int = 1
    var presenter:MovieInteractorToPresenterProtocol?
    var currentPromise: Promise<MovieResult>?
    func fetchNowMovies() {
        fecthNowMovies(withDelay: 0)
    }
    func getMovie(byIndex index: Int) {
        guard 0..<movies.count ~= index  else{
            return
        }
        let movie = movies[index]
        presenter?.movieSelected(movie: movie)
    }
    func fetchMoreNowMovies() {
        currentPage += 1
        fecthNowMovies(withDelay: 0)
    }
    func reloadNowMovies() {
        currentPage = 1
        fecthNowMovies(withDelay: 3)
    }
    private func fecthNowMovies(withDelay delay: TimeInterval){
        
        currentPromise = MovieService.getNowMovies(page: currentPage, delay)
        currentPromise?.then { (moviesResult) in
            self.currentPromise = nil
            if let movies = moviesResult.results{
                if self.currentPage == 1{
                    self.movies = [Movie]()
                    self.movies = movies
                    self.presenter?.nowMoviesReseted(movies: self.movies)
                }else{
                    self.movies += movies
                    self.presenter?.nowMoviesFetchedSuccess(movies: self.movies)
                }
                
            }else{
                self.presenter?.nowMoviesFetchFailed(error: "No existen peliculas")
            }
        }.catch { (error) in
            if let error = error as? APIServiceError{
                self.presenter?.nowMoviesFetchFailed(error: error.message ?? "")
            }
            else{
                self.presenter?.nowMoviesFetchCanceled()
            }
        }
    }
    func cancelFetch(){
        guard currentPromise != nil else{
            return
        }
        currentPromise?.reject(ErrorType.canceled)
        currentPromise = nil
    }
}
