//
//  User.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation

public struct User: Codable {
    public let id: Int?
    public let login: String?
    public let avatar_url: String?
    public let url: String?
    public let name: String?
    public let email: String?
    public let followers: Int?
    public let following: Int?
    public let created_at: String?
}
