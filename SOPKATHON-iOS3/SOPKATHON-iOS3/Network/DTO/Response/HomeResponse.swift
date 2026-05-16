//
//  HomeResponse.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import Foundation

struct HomeData: Codable {
    let user: UserInfo
    let dates: [DateStrip]
}

struct UserInfo: Codable {
    let userId: Int
    let name: String
    let streakCount: Int
}

struct DateStrip: Codable {
    let date: String
    let dayOfWeek: String  
    let hasMistake: Bool
    
    var formattedDate: String {
        let components = date.components(separatedBy: "-")
        if components.count == 3 {
            let month = Int(components[1]) ?? 0
            let day = Int(components[2]) ?? 0
            return "\(month) / \(day)"
        }
        return date
    }
}
