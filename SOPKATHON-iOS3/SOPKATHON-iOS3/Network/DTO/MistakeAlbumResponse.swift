//
//  TestStruct.swift
//  SOPKATHON-iOS3
//
//  Created by 정교은 on 5/17/26.
//

import Foundation

struct MistakeAlbumResponse: Codable {
    let code: String
    let success: Bool
    let message: String
    let data: MistakeAlbumData
}

struct MistakeAlbumData: Codable {
    let items: [MistakeAlbumListItem]
    let nextCursor: Int?
    let hasNext: Bool
}

struct MistakeAlbumListItem: Codable {
    let mistakeId: Int
    let imageUrl: String
    let date: String
    let hasReflection: Bool
    let emojiIndex: Int?
}
