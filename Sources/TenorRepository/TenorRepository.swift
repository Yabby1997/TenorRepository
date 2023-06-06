//
//  File.swift
//  
//
//  Created by USER on 2023/06/06.
//

import Foundation
import GIFPediaService
import SHNetworkServiceInterface

public final class TenorRepository: GIFRepository {
    private let networkService: SHNetworkServiceInterface
    private let apiKey: String
    private let limit: Int
    private var latestQuery: String = ""
    private var nextPosition: String = ""

    public init(networkService: SHNetworkServiceInterface, apiKey: String, limit: Int = 100) {
        self.networkService = networkService
        self.apiKey = apiKey
        self.limit = limit
    }

    public func search(query: String) async -> [GIF] {
        do {
            let results = try await search(query: query, position: "")
            latestQuery = query
            return results
        } catch {
            dump(error.localizedDescription)
            return []
        }
    }

    public func requestNext() async -> [GIF] {
        do {
            return try await search(query: latestQuery, position: nextPosition)
        } catch {
            dump(error.localizedDescription)
            return []
        }
    }

    private func search(query: String, position: String) async throws -> [GIF] {
        let result: TenorSearchResultDTO = try await networkService.request(
            domain: "https://tenor.googleapis.com/v2",
            path: "/search",
            method: .get,
            parameters: [
                "q": query,
                "key": apiKey,
                "limit": "\(limit)",
                "pos": "\(position)",
                "rating": "g",
                "locale": "en"
            ],
            headers: nil,
            body: nil
        )

        nextPosition = result.next
    
        return result.results.compactMap { dto -> GIF? in
            guard let thumbnailUrl = dto.gifPreviewUrl,
                  let originalUrl = dto.gifUrl else { return nil }
            return GIF(
                id: "Tenor_\(dto.id)",
                title: dto.title,
                thumbnailUrl: thumbnailUrl,
                originalUrl: originalUrl
            )
        }
    }
}
