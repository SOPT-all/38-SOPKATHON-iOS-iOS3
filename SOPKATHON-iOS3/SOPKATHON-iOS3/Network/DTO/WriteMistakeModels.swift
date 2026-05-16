//
//  WriteMistakeModels.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import Foundation

struct PresignedUploadRequest: Codable {
    let originalFileName: String
    let contentType: String
    let contentLength: Int
}

struct PresignedUploadData: Codable {
    let objectKey: String
    let uploadUrl: String
    let expiresInSeconds: Int
}

struct ImageCompleteRequest: Codable {
    let objectKey: String
    let contentType: String
    let contentLength: Int
}

struct ImageCompleteData: Codable {
    let objectKey: String
    let publicUrl: String
}

struct CreateMistakeRequest: Codable {
    let imageObjectKey: String
    let title: String
    let content: String
}
