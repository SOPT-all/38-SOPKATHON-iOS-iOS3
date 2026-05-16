//
//  PostReviewAPI.swift
//  SOPKATHON-iOS3
//
//  Created by Codex on 5/17/26.
//

import Foundation

import Alamofire
import Moya

enum PostReviewAPI {
    case postReview(userId: Int, mistakeId: Int, body: PostReviewRequest)
}

extension PostReviewAPI: BaseTargetType {
    var path: String {
        switch self {
        case .postReview(_, let mistakeId, _):
            return "/v1/mistakes/\(mistakeId)/reflections"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postReview:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postReview(_, _, let body):
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postReview(let userId, _, _):
            return [
                "Content-Type": "application/json",
                "User-Id": String(userId)
            ]
        }
    }
}
