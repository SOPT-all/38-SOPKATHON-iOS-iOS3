//
//  GenericResponse.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: T?
}

// TODO: - 당일에 명세보고 수정하기
