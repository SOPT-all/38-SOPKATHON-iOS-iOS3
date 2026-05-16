//
//  MistakeService.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//


import Foundation
import Moya

final class MistakeService {
    
    static let shared = MistakeService()
    
    private let provider = MoyaProvider<MistakeAPI>(plugins: [MoyaLoggerPlugin()])
    
    private init() {}
    
    // MARK: - 수민 !!!!!!!!!!!!!!!!!!!!!!!
    
    func getHomeData(userId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getHome(userId: userId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, HomeData.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    // MARK: - 승희 !!!!!!!!!!!!!!!!!!!!!!!
    
    
    
    
    // MARK: - 교은 !!!!!!!!!!!!!!!!!!!!!!!
    
    
    // MARK: - 서버 상태 코드 분기 처리 (공통)
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200..<300:
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
