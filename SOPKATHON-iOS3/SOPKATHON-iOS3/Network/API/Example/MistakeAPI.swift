//
//  MistakeAPI.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import Foundation
import Alamofire
import Moya

enum MistakeAPI {
    // MARK: - 1. Home
    case getHome(userId: Int)
    
    // MARK: - 2. Mistakes
    case createMistake(userId: Int, body: Codable)
    case getMistakeList(userId: Int, cursor: Int?, size: Int?)
    case getMistakeDetail(userId: Int, mistakeId: Int)
    case createReflection(userId: Int, mistakeId: Int, body: Codable)
    
    // MARK: - 3. Images
    case issuePresignedURL(body: Codable)
    case verifyImageUploadComplete(body: Codable)
}

extension MistakeAPI: BaseTargetType {
    
    var path: String {
        switch self {
        case .getHome:
            return "/v1/home"
            
        case .createMistake, .getMistakeList:
            return "/v1/mistakes"
            
        case .getMistakeDetail(_, let mistakeId):
            return "/v1/mistakes/\(mistakeId)"
            
        case .createReflection(_, let mistakeId, _):
            return "/v1/mistakes/\(mistakeId)/reflections"
            
        case .issuePresignedURL:
            return "/v1/images/presigned-upload"
            
        case .verifyImageUploadComplete:
            return "/v1/images/complete"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHome, .getMistakeList, .getMistakeDetail:
            return .get
        case .createMistake, .createReflection, .issuePresignedURL, .verifyImageUploadComplete:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getHome, .getMistakeDetail:
            return .requestPlain
            
        case .createMistake(_, let body):
            return .requestJSONEncodable(body)
            
        case .getMistakeList(_, let cursor, let size):
            var params: [String: Any] = [:]
            if let cursor = cursor { params["cursor"] = cursor }
            if let size = size { params["size"] = size }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .createReflection(_, _, let body):
            return .requestJSONEncodable(body)
            
        case .issuePresignedURL(let body):
            return .requestJSONEncodable(body)
            
        case .verifyImageUploadComplete(let body):
            return .requestJSONEncodable(body)
        }
    }
    
    var headers: [String : String]? {
        var currentHeaders = ["Content-Type": "application/json"]
        
        switch self {
        case .getHome(let userId),
             .createMistake(let userId, _),
             .getMistakeList(let userId, _, _),
             .getMistakeDetail(let userId, _),
             .createReflection(let userId, _, _):
            currentHeaders["User-Id"] = String(userId)
            return currentHeaders
            
        case .issuePresignedURL, .verifyImageUploadComplete:
            return currentHeaders
        }
    }
}
