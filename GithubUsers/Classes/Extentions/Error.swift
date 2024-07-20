//
//  Error.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation

struct DescriptiveError: LocalizedError {
    let errorDescription: String?
    init(_ errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
