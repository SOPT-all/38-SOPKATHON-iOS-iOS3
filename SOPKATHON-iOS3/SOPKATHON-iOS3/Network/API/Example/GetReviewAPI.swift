//
//  GetReviewAPI.swift
//  SOPKATHON-iOS3
//
//  Created by Codex on 5/17/26.
//

import Foundation

import Alamofire
import Moya

enum GetReviewAPI {
    case getReview(userId: Int, mistakeId: Int)
}

extension GetReviewAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getReview(_, let mistakeId):
            return "/v1/mistakes/\(mistakeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getReview:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getReview:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getReview(let userId, _):
            return [
                "Content-Type": "application/json",
                "User-Id": String(userId)
            ]
        }
    }
}
