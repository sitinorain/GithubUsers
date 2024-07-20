//
//  UserService.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import Alamofire

public class UserService {
    public func getUserList(completionHandler: @escaping (Result<[User], Error>) -> Void) {
        let urlString = Endpoint.getUsers()
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completionHandler(.failure(APIServiceError.invalidUrl))
            }
            return
        }
        
        APIService.publicRequest(url: url, method: .get) { (response) in
            switch response {
            case .success(let data):
                do {
                    let users: [User] = try JSONDecoder().decode([User].self, from: data)
                    if !users.isEmpty {
                        DispatchQueue.main.async {
                            completionHandler(.success(users))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completionHandler(.failure(APIServiceError.noData))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(DescriptiveError("Serialization Error")))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    public func getUserDetails(_ id: Int, completionHandler: @escaping (Result<User, Error>) -> Void) {
        let urlString = Endpoint.getUserDetails(id)
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completionHandler(.failure(APIServiceError.invalidUrl))
            }
            return
        }
        
        APIService.publicRequest(url: url, method: .get) { (response) in
            switch response {
            case .success(let data):
                do {
                    let user: User = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(user))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(DescriptiveError("Serialization Error")))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
