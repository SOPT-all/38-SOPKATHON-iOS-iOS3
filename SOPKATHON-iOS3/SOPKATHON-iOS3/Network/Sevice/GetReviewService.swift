//
//  GetReviewService.swift
//  SOPKATHON-iOS3
//
//  Created by Codex on 5/17/26.
//

import Foundation

import Moya

final class GetReviewService {
    
    static let shared = GetReviewService()
    
    private let provider = MoyaProvider<GetReviewAPI>(plugins: [MoyaLoggerPlugin()])
    
    private init() {}
    
    func getReview(
        userId: Int,
        mistakeId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.getReview(userId: userId, mistakeId: mistakeId)) { result in
            switch result {
            case .success(let response):
                completion(self.judgeStatus(by: response.statusCode, response.data, GetReviewResponse.self))
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
