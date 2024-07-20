//
//  Data+Extension.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation

protocol ReadJsonFromFile {
    func readJson(_ fromTarget: AnyClass, fromFile: String) -> Data?
}

extension ReadJsonFromFile {
    func readJson(_ fromTarget: AnyClass, fromFile: String) -> Data? {
        guard let pathString = Bundle(for: fromTarget).path(forResource: fromFile, ofType: "json") else { return nil }
        guard let pathJson = try? String(contentsOfFile: pathString) else { return nil }
        let data = pathJson.data(using: .utf8)
        return data
    }
}

extension Data {
    func parseTo<T: Codable>(typeClass: T.Type) -> T? {
        guard let model = try? JSONDecoder().decode(typeClass.self, from: self) else { return nil }
        return model
    }

    func parseTo<T: Codable>(typeClass: [T].Type) -> [T]? {
        guard let model = try? JSONDecoder().decode(typeClass.self, from: self) else { return nil }
        return model
    }
}
