//
//  Routing.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import UIKit
class MovieRouter: MoviePresenterToRouterProtocol{
    weak var viewController :MoviesCollectionViewController!
    weak var navigationConroller: UINavigationController!
    static var storyBoard: UIStoryboard{
        return  UIStoryboard(name: "Movie", bundle: nil)
    }
    static func createModule() -> UIViewController {
        let movieVC = MovieRouter.storyBoard.instantiateViewController(withIdentifier: "MoviesCollectionViewController") as! MoviesCollectionViewController
        let navigationController = UINavigationController.init(rootViewController: movieVC)
        let presenter: MoviePresenter = MoviePresenter()
        let interactor: MoviePresenterToInteractorProtocol = MovieInteractor()
        let router:MovieRouter = MovieRouter()
        router.viewController = movieVC
        router.navigationConroller = navigationController
        movieVC.modalPresentationStyle = .fullScreen
        movieVC.presenter = presenter
        presenter.view = movieVC
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navigationController
    }
    
    func pushToDetailMovieScreen(movie:Movie) {
        let movieDetailViewController = MovieDetailRouter.createModule(movie: movie, navigationViewController: navigationConroller)
        movieDetailViewController.modalPresentationStyle = .fullScreen
        navigationConroller.pushViewController(movieDetailViewController, animated: true)
    }
}
