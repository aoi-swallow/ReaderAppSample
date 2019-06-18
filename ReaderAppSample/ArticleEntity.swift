//
//  ArticleEntity.swift
//  ReaderAppSample
//
//  Created by 大川葵 on 2019/06/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import SwiftyJSON

// MARK: - ArticleEntity
class ArticleEntity {
    
    var title: String = ""
    var updatedAt: String = ""
    var tags: [String] = []
    
    required init(json: JSON, index: Int) {
        self.title = json[index]["title"].stringValue
        self.updatedAt = json[index]["updated_at"].stringValue
        let tagArray = json[index]["tags"].arrayValue
        for tag in tagArray {
            self.tags.append(tag["name"].stringValue)
        }
    }
}

class ArticleListEntity {
    
    var articles: [ArticleEntity] = []
    
    required init(json: JSON) {
        for i in 0..<10 {
            self.articles.append(ArticleEntity(json: json, index: i))
        }
    }
}
