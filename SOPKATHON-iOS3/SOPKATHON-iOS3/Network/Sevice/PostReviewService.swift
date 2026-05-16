//
//  PostReviewService.swift
//  SOPKATHON-iOS3
//
//  Created by Codex on 5/17/26.
//

import Foundation

import Moya

final class PostReviewService {
    
    static let shared = PostReviewService()
    
    private let provider = MoyaProvider<PostReviewAPI>(plugins: [MoyaLoggerPlugin()])
    
    private init() {}
    
    func postReview(
        userId: Int,
        mistakeId: Int,
        request: PostReviewRequest,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.postReview(userId: userId, mistakeId: mistakeId, body: request)) { result in
            switch result {
            case .success(let response):
                completion(self.judgeStatus(by: response.statusCode, response.data, PostReviewResponse.self))
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200..<300:
            if let data = decodedData.data {
                return .success(data)
            }
            return .pathErr
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
