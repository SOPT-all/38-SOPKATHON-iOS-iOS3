//
//  SignupRequest.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

/// 예시 !!!!!!!!! 서버로 보낼 때 (Request Body 있는 api)

struct SignupRequest: Codable {
    let loginId, password, name, email: String
    let age: Int
    let part: String
}
