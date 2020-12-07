//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
class MovieDetailPresenter {
    var view: MovieDetailPresenterToViewProtol?
    var interactor: MovieDetailPresenterToInteractorProtocol?
    var router:MovieDetailPresenterToRouterProtocol?
    let movie: Movie
    init(movie: Movie){
        self.movie = movie
    }
}
extension MovieDetailPresenter:MovieDetailViewToPresenterProtocol{
    func goBack() {
        router?.popToMovieScreen()
    }
    
    func reloadData() {
        view?.displayLoading()
        interactor?.fetchMovieDetail(id: movie.id)
    }
}
extension MovieDetailPresenter:MovieDetailInteractorToPresenterProtocol{
    func movieDetailFetchedSuccess(movieDetail: MovieDetail) {
        view?.display(movieDetail: movieDetail)
    }
    
    func movieDetailFetchFailed(error: String) {
        view?.display(error: error)
    }
    
    
}
