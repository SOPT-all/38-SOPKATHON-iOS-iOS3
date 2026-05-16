//
//  MistakeService.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//


import Foundation

import Alamofire
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
    
    // MARK: - [1단계] Presigned URL & ObjectKey 발급
    func issuePresignedURL(filename: String, type: String, size: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let requestBody = PresignedUploadRequest(originalFileName: filename, contentType: type, contentLength: size)
        
        provider.request(.issuePresignedURL(body: requestBody)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, PresignedUploadData.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func uploadImageBinary(url: String, imageData: Data, contentType: String, completion: @escaping (Bool) -> Void) {
        // 1. 헤더를 설정하지 않거나 빈 상태로 보냅니다. (Content-Type 제거)
        let headers = HTTPHeaders()
        
        AF.upload(imageData, to: url, method: .put, headers: headers)
            .responseData { response in
                print(response)
                if let statusCode = response.response?.statusCode, (200..<300).contains(statusCode) {
                    print("💻 외부 스토리지 바이너리 업로드 완료!")
                    completion(true)
                } else {
                    if let code = response.response?.statusCode {
                        print("❌ 바이너리 업로드 실패 (상태코드: \(code))")
                    }
                    completion(false)
                }
            }
    }
    
    func verifyImageUploadComplete(objectKey: String, type: String, size: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let requestBody = ImageCompleteRequest(objectKey: objectKey, contentType: type, contentLength: size)
        
        provider.request(.verifyImageUploadComplete(body: requestBody)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, ImageCompleteData.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func createMistake(userId: Int, title: String, content: String, objectKey: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let requestBody = CreateMistakeRequest(imageObjectKey: objectKey, title: title, content: content)
        
        provider.request(.createMistake(userId: userId, body: requestBody)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String?.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    // MARK: - 승희 !!!!!!!!!!!!!!!!!!!!!!!
    
    
    
    
    // MARK: - 교은 !!!!!!!!!!!!!!!!!!!!!!!
    
    func getMistakeAlbumData(
        userId: Int,
        cursor: Int?,
        size: Int?,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.getMistakeList(userId: userId, cursor: cursor, size: size)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, MistakeAlbumData.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    
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

