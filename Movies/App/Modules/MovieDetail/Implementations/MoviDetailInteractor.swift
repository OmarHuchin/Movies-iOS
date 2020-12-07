//
//  MoviDetailInteractor.swift
//  Movies
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
class MovieDetailInteractor: MovieDetailPresenterToInteractorProtocol{
    var presenter:MovieDetailInteractorToPresenterProtocol?
    func fetchMovieDetail(id: Int?) {
        guard let id = id else{
            presenter?.movieDetailFetchFailed(error: "Película no valida")
            return
        }
        MovieDetailService.getMoviewDetail(id: id).delay(0).then { (movieDetail) in
            self.presenter?.movieDetailFetchedSuccess(movieDetail: movieDetail)
        }.catch { (error) in
            if let error = error as? APIServiceError{
                self.presenter?.movieDetailFetchFailed(error: error.message.safeValue)
            }
            
        }
    }
}
