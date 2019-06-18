//
//  ApiService.swift
//  ReaderAppSample
//
//  Created by 大川葵 on 2019/06/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Moya

enum ApiService {
    case getData(query: String, page: Int)
}

extension ApiService: TargetType {
    var baseURL: URL {
        switch self {
        case .getData:
            return URL(string: "https://qiita.com")!
        }
    }
    
    var path: String {
        switch self {
        case .getData:
            return "/api/v2/items"
        }
    }
    
    var method: Method {
        switch self {
        case .getData:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getData(let query, let page):
            return .requestParameters(parameters: ["per_page": 10,"query": query, "page": page], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getData:
            return ["Content-Type" : "application/json"]
        }
    }
    
    
}




