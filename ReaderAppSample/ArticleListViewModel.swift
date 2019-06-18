//
//  ArticleListViewModel.swift
//  ReaderAppSample
//
//  Created by 大川葵 on 2019/06/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - ArticleListViewModel
final class ArticleListViewModel: ViewModel {
    
    typealias ViewController = ArticleListViewController
    
    init(_ viewController: ArticleListViewController) {
        
        self.viewController = viewController
        self.loadStatus = .initial
        page = 1
        searchWord = "Swift"
    }
    
    
    // MARK: Private
    
    private weak var viewController: ViewController?
    private let shared = DataModel.shared
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var articles: [ArticleEntity] = []
    var page: Int = 1
    var searchWord: String = "Swift"
    var loadStatus: LoadStatus?
    private(set) var refreshToggle = PublishRelay<Void>()
    private(set) var alertToggle = PublishRelay<(String, String)>()
    
    func search() {
        
        guard loadStatus == .initial else {
            return
        }
        self.loadStatus = .fetching
        self.shared.sync(query: self.searchWord, page: self.page)
            .subscribe { [weak self] result in
                switch result {
                case .success(let data):
                    self?.articles.append(contentsOf: data.articles)
                    if data.articles.count != 0 {
                        self?.refreshToggle.accept(())
                        self?.page += 1
                        self?.loadStatus = .initial
                    } else {
                        self?.loadStatus = .full
                    }
                case .error(let error):
                    print(error)
                    self?.alertToggle.accept(("Error", "データを取得できませんでした"))
                    self?.loadStatus = .initial
                }
            }.disposed(by: disposeBag)
    }
    
    func resetResult() {
        
        self.articles = []
        self.page = 1
    }
}

protocol ViewModel {
    associatedtype ViewController
    init(_ viewController: ViewController)
}


