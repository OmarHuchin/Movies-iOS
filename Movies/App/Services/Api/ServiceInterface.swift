//
//  ServiceInterface.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Promises
protocol ServiceInterface: class{
    /// Retrieve promise with an object as value
    /// - Parameters:
    ///   - url: URL of petition
    ///   - parameters: Parameteres
    ///   - timeOut: Time out
    ///   - queue: Queue of call
    ///   - showMessageError: True if you want to process a message error automatically
    ///   - responseType: Type of response
    func request<T : Codable>(apiRequest: APIRequest, responseType : T.Type,_ delay: TimeInterval)->Promise<T>
}
