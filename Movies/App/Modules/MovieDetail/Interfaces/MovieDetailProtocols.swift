//
//  MovieDetailProtocols.swift
//  Movies
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
protocol MovieDetailViewToPresenterProtocol {
    func goBack()
    func reloadData()
}
protocol MovieDetailPresenterToViewProtol {
    var presenter: MovieDetailPresenter? { get set }
    func displayLoading()
    func display(movieDetail: MovieDetail)
    func display(error: String)
}
protocol MovieDetailPresenterToRouterProtocol {
    func popToMovieScreen()
}
protocol MovieDetailPresenterToInteractorProtocol: class {
    var presenter:MovieDetailInteractorToPresenterProtocol? {get set}
    func fetchMovieDetail(id: Int?)
}

protocol MovieDetailInteractorToPresenterProtocol: class {
    func movieDetailFetchedSuccess(movieDetail: MovieDetail)
    func movieDetailFetchFailed(error: String)
}
