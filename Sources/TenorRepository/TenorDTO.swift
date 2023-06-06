//
//  TenorDTO.swift
//  TenorRepository
//
//  Created by USER on 2023/06/06.
//

import Foundation

struct TenorSearchResultDTO: Decodable {
    let results: [TenorEntityDTO]
    let next: String
}

struct TenorEntityDTO: Decodable {
    let id: String
    let title: String
    let images: [String: TenorImageDTO]

    var originalUrl: URL? {
        guard let url = images["gif"]?.url else { return nil }
        return URL(string: url)
    }

    var thumbnailUrl: URL? {
        guard let url = images["tinygif"]?.url else { return nil }
        return URL(string: url)
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case images = "media_formats"
    }
}

struct TenorImageDTO: Codable {
    let url: String
}
