//
//  APIService.swift
//  Movies
//
//  Created by Omar Huchin on 05/12/20.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Alamofire
import Promises
public class APIService: ServiceInterface{
    private var sessionManager: SessionManager!
    public var host = ""
    public var apiVersion = ""
    public var apiKey = ""
    public var imageHost = ""
    public static let shared = APIService()
    private let defaultTimeOut: TimeInterval = 15
    init() {
        let headers = Alamofire.SessionManager.defaultHTTPHeaders
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = defaultTimeOut
        config.httpAdditionalHeaders = headers
        sessionManager = Alamofire.SessionManager(configuration: config)
    }
    
    func request<T>(apiRequest: APIRequest, responseType: T.Type,_ delay: TimeInterval = 0) -> Promise<T> where T : Decodable, T : Encodable {
        guard ConnectivityHelper.isConnected, let urlRequest = getURLRequest(apiRequest: apiRequest) else {
            if !ConnectivityHelper.isConnected{
                return Promise(APIServiceError(message: "No tienes conexión a internet"))
            }
            return Promise(APIServiceError(message: "Request no valido"))
        }
        let promiseResponse = Promise<T>.pending()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delay) {
            self.sessionManager.request(urlRequest).validate().responseData { [unowned self] (response) in
                let statusCode = response.response?.statusCode
                switch response.result{
                case .success(let value):
                    do{
                        let result = try JSONDecoder().decode(T.self, from: value)
                        promiseResponse.fulfill(result)
                    }
                    catch let myError {
                        print(myError)
                        self.rejectError(fromData: value, promise: promiseResponse, statusCode: statusCode)
                    }
                    break
                case .failure(_):
                    self.rejectError(fromData: response.data, promise: promiseResponse, statusCode: statusCode)
                    break
                }
            }
        }
        return promiseResponse
    }
    private func getURLRequest(apiRequest: APIRequest)->URLRequest?{
        do{
            var parameters = apiRequest.parameters ?? Parameters()
            parameters["language"] = "es"
            parameters["api_key"] = apiKey
            var url = try self.host.asURL()
            url.appendPathComponent(apiVersion)
            url.appendPathComponent(apiRequest.path)
            var urlRequest = try URLRequest(url: url, method: apiRequest.method)
            urlRequest = try apiRequest.encoding.encode(urlRequest, with: parameters)
            urlRequest.timeoutInterval = apiRequest.timeOut
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return urlRequest
        }catch{
            return nil
        }
    }
    private func rejectError<T>(fromData data: Data?, promise: Promise<T>, statusCode: Int? = nil)where T : Decodable, T : Encodable  {
        guard let data = data else {
            promise.reject(APIServiceError(message: "Existe un problema al procesar tu solicitud, por favor intenta mas tardes", code: statusCode))
            return
        }
        var error: APIServiceError! = nil
        do{
            error = try JSONDecoder().decode(APIServiceError.self, from: data)
            promise.reject(error)
        }
        catch let myError {
            print(myError)
            error = APIServiceError(message: "Existe un problema al procesar tu solicitud, por favor intenta mas tardes", code: statusCode)
            promise.reject(error)
        }
    }
}
