//
//  RoomInfoResponse.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

/// 예시 !!!!!!!!! 서버로부터 데이터 받을 때 (Response Body 있는 api)

struct RoomInfoResponse: Codable {
    let code: Int
    let message: String
    let data: RoomInfo
}

struct RoomInfo: Codable {
    let location: String
    let monthlyRent: Int
    let period: String
    let roomCount: Int
    let bathroomCount: Int
    let washerCount: Int
}
