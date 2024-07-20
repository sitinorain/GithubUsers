//
//  APIService.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import UIKit
import Alamofire

let ServiceURL: String = {
    return "https://api.github.com/"
}()

struct Endpoint {
    static func getUsers() -> String {
        return ServiceURL + "users"
    }
    
    static func getUserDetails(_ id: Int) -> String {
        return ServiceURL + "user/\(id)"
    }
}

extension HTTPHeaders {
    static func jsonHeader() -> HTTPHeaders {
        let headers:HTTPHeaders = HTTPHeaders.init(["Content-Type": "application/json;charset=UTF-8"])
        return headers
    }
    
    static func formHeader() -> HTTPHeaders {
        let headers:HTTPHeaders = HTTPHeaders.init(["Content-type": "multipart/form-data"])
        return headers
    }
}

public enum APIServiceError: Error {
    case invalidSession
    case invalidUrl
    case unexpectedError
    case unauthorized
    case noData
}

extension APIServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidSession:
            return Constants.ErrorMessage.invalid_session
        case .invalidUrl:
            return Constants.ErrorMessage.invalid_url
        case .unexpectedError:
            return Constants.ErrorMessage.unexpected_error
        case .unauthorized:
            return Constants.ErrorMessage.unauthorized_error
        case .noData:
            return Constants.ErrorMessage.no_data
        }
    }
}

class APIService: NSObject {
    class func publicRequest(url: URL,
                             method: HTTPMethod,
                             parameters: Parameters? = nil,
                             completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        let headers: HTTPHeaders = HTTPHeaders.jsonHeader()
        APIService.request(url: url, method: method, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    private class func request(url: URL,
                               method: HTTPMethod,
                               parameters: Parameters? = nil,
                               headers: HTTPHeaders? = HTTPHeaders.jsonHeader(),
                               completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        let encoding = JSONEncoding.default
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completionHandler(.failure(APIServiceError.unexpectedError))
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(.success(data))
                    }
                
                case .failure(let error):
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
        }
    }
}

