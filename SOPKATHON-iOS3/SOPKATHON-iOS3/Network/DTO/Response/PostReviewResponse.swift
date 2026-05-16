//
//  PostReviewResponse.swift
//  SOPKATHON-iOS3
//
//  Created by Codex on 5/17/26.
//

import Foundation

struct PostReviewResponse: Codable {
    let reflectionId: Int
    let mistakeId: Int
    let emojiIndex: Int
    let content: String
    let createdAt: String
}
