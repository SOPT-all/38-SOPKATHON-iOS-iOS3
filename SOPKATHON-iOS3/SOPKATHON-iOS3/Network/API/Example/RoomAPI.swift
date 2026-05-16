//
//  RoomAPI.swift
//  37-SOPKATHON-iOS-iOS3
//
//  Created by 김수민 on 5/16/25.
//

/// 예시 !!!!!!!!! 전체 api

import Foundation

import Alamofire
import Moya

enum RoomAPI {
  case roomInfo(roomId: Int)
  case getRoommate(roomId: Int)
}

extension RoomAPI: BaseTargetType {
  
  var path: String {
    switch self {
    case .roomInfo(let roomId):
      return "/rooms/\(roomId)"
    case .getRoommate(let roomId):
      return "/rooms/\(roomId)/roommmate"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .roomInfo:
      return .get
    case .getRoommate:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .roomInfo(_):
      return .requestPlain
    case .getRoommate(_):
      return .requestPlain
    }
  }
}

//// 실제로 사용할 때 이런식으로 사용하시면됩니다.

//func sendFlagToServer() {
//        let provider = MoyaProvider<FlagPlusAPI>()
//
//        // Create a FlagPlus object with appropriate data
//        let flagData = FlagPlus(
//            name: FlagPlusInfo.shared.name,
//            dates: FlagPlusInfo.shared.dates,
//            guestNames: FlagPlusInfo.shared.guestId,
//            memo: FlagPlusInfo.shared.memo,
//            minTime: FlagPlusInfo.shared.minTime,
//            place: FlagPlusInfo.shared.place,
//            possibleDates: FlagPlusInfo.shared.possibleDates, // UNIX timestamps
//            timeSlot: FlagPlusInfo.shared.timeSlot
//        )
//
//        // Make the API request
//    provider.request(.setFlag(body: flagData)) { result in
//        switch result {
//        case .success(let response):
//            // Handle successful response
//            let statusCode = response.statusCode
//            print("Status Code: \(statusCode)")
//            // Process the response data as needed
//
//        case .failure(let error):
//            // Handle network error
//            print("Network Error: \(error)")
//        }
//    }
//
//    }
//}
