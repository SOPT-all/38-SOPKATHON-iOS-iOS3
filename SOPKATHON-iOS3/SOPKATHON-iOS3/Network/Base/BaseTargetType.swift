//
//  BaseTargetType.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType{

    var baseURL: URL {
        return URL(string: "https://api.sopkathon38-ios3.p-e.kr")!
    }

    var headers: [String : String]? {
        let header = [
            "Content-Type": "application/json"
        ]
        return header
    }

    var sampleData: Data {
        return Data()
    }
}
