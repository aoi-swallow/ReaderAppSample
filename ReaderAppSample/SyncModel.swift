//
//  SyncModel.swift
//  ReaderAppSample
//
//  Created by 大川葵 on 2019/06/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Moya
import SwiftyJSON
import RxSwift
import RxCocoa
import Alamofire

// MARK: - DataModel
final class DataModel {
    
    public static let shared = DataModel()
    private init() {}
    
    private let provider = MoyaProvider<ApiService>()
    
    func sync(query: String, page: Int) -> Single<ArticleListEntity> {
        var data: ArticleListEntity?
        return Single.create { observer in
            self.provider.request(ApiService.getData(query: query, page: page), completion: { (result) in
                switch result {
                case .success(let response):
                    let json = JSON(response.data)
                    data = ArticleListEntity(json: json)
                    observer(.success(data!))
                case .failure(let error):
                    print(error)
                    observer(.error(error))
                }
            })
            return Disposables.create()
        }
    }
}


