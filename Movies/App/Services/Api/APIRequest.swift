//
//  APISetting.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Alamofire
public protocol APIRequest {
    var encoding: ParameterEncoding {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
    var path: String {get}
    var timeOut: TimeInterval {get}
}
public extension APIRequest{
    var timeOut: TimeInterval{
        return 15
    }
    var encoding: ParameterEncoding{
        return URLEncoding.default
    }
    var method: HTTPMethod{
        return HTTPMethod.get
    }
}
