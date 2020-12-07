//
//  MovieDetailService.swift
//  Movies
//
//  Created by Omar Huchin on 06/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Promises
import Alamofire

enum MovieDetailServiceRouter: APIRequest{
    case getPlayingMovies(page: Int)
    case getMovieDetail(id:Int)
    
    public var parameters: Parameters?{
        var _parameters = Parameters()
        switch self{
        case .getPlayingMovies(let page):
            _parameters["page"] = page
            return _parameters
            
        case .getMovieDetail(_):
            return nil
        }
    }
    
    public var path: String{
        switch self{
        case .getPlayingMovies(_):
            return EndPoints.Movies.nowPlaying
            
        case .getMovieDetail(let id):
            return String(format: EndPoints.Movies.movieDetail, id)
        }
    }
}
struct MovieDetailService{
    static func getMoviewDetail(id: Int) -> Promise<MovieDetail> {
        return APIService.shared.request(apiRequest: MovieServiceRouter.getMovieDetail(id: id), responseType: MovieDetail.self)
    }
    
    static func getNowMovies(page: Int) -> Promise<MovieResult> {
        return APIService.shared.request(apiRequest: MovieServiceRouter.getPlayingMovies(page: page), responseType: MovieResult.self)
    }
    
    
}
