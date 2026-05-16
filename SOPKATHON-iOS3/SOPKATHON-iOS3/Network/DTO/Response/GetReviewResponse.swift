//
//  GetReviewResponse.swift
//  SOPKATHON-iOS3
//
//  Created by Codex on 5/17/26.
//

import Foundation

struct GetReviewResponse: Codable {
    let mistakeId: Int
    let imageUrl: String
    let title: String
    let content: String
    let date: String
    let hasReflection: Bool
    let reflection: ReflectionInfo?
}

struct ReflectionInfo: Codable {
    let reflectionId: Int
    let content: String
    let emojiIndex: Int
    let createdAt: String
}
