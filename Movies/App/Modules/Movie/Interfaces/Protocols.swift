//
//  Protocols.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import UIKit
protocol MovieViewToPresenterProtocol {
    func showNowMovies()
    func getSizeItem(collectionView: UICollectionView)-> CGSize
    func didSelect(indexPath: IndexPath)
    func didScroll(scrollView: UIScrollView)
}
protocol MoviePresenterToViewProtol : class{
    func displayLoading()
    func display(movies: [Movie])
    func display(error: String)
    func hideLoading()
}
protocol MoviePresenterToRouterProtocol {
    func pushToDetailMovieScreen(movie:Movie)
}
protocol MoviePresenterToInteractorProtocol: class {
    var presenter:MovieInteractorToPresenterProtocol? {get set}
    func fetchNowMovies()
    func fetchMoreNowMovies()
    func reloadNowMovies()
    func cancelFetch()
    func getMovie(byIndex index: Int)
}

protocol MovieInteractorToPresenterProtocol: class {
    func nowMoviesFetchedSuccess(movies: [Movie])
    func nowMoviesFetchFailed(error: String)
    func movieSelected(movie: Movie)
    func nowMoviesFetchCanceled()
    func nowMoviesReseted(movies: [Movie])
}
