//
//  MovieDetailRouter.swift
//  Movies
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import UIKit
class MovieDetailRouter: MovieDetailPresenterToRouterProtocol{
    weak var navigationViewController: UINavigationController!
    weak var viewController: UIViewController?
   
    static var storyBoard: UIStoryboard{
        return  UIStoryboard(name: "Movie", bundle: nil)
    }
    static func createModule(movie: Movie, navigationViewController: UINavigationController) -> UIViewController {
        let view = MovieDetailRouter.storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let presenter: MovieDetailPresenter = MovieDetailPresenter(movie: movie)
        let interactor: MovieDetailPresenterToInteractorProtocol = MovieDetailInteractor()
        let router:MovieDetailRouter = MovieDetailRouter()
        router.viewController = view
        router.navigationViewController = navigationViewController
        view.modalPresentationStyle = .fullScreen
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    func popToMovieScreen() {
        navigationViewController?.popViewController(animated: true)
    }
}
