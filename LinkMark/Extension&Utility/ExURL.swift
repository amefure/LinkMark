//
//  ExURL.swift
//  LinkMark
//
//  Created by t&a on 2024/01/27.
//

import SwiftUI
import LinkPresentation

extension URL {
    // URLのタイトルを取得する
    static func fetchMetadataTitle(url: URL) async throws -> String {
        let metadataProvider = LPMetadataProvider()
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<String, Error>) in
            metadataProvider.startFetchingMetadata(for: url) { metadata, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let metadata {
                    continuation.resume(returning: metadata.title ?? "")
                } else {
                    continuation.resume(throwing: LPError(.unknown))
                }
            }
        }
    }
}
