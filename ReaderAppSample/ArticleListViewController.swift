//
//  ArticleListViewController.swift
//  ReaderAppSample
//
//  Created by 大川葵 on 2019/06/18.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

// MARK: ArticleListViewController
final class ArticleListViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewModel = ArticleListViewModel(self)
        self.tableView.register(R.nib.articleCell)
        // インジケーターを表示するセル
        self.tableView.register(R.nib.loadingCell)
        let footerCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.loadingCell.identifier)!
        (footerCell as! LoadingCell).startAnimation()
        let footerView: UIView = footerCell.contentView
        tableView.tableFooterView = footerView
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 200
        self.searchBar.delegate = self
        
        viewModel?.refreshToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel?.alertToggle.asSignal()
            .emit(onNext: { [weak self] (title, message) in
                self?.showAlert(title: title, message: message)
            })
            .disposed(by: disposeBag)
        
        viewModel?.search()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    private func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: Internal
    
    var viewModel: ArticleListViewModel?
    var dateFormatter = DateFormatter()
    
    // 一番下にたどりつく500px前に次のapiを叩く
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        if distanceToBottom < 500 && tableView.isDragging {
            self.viewModel?.search()
        }
    }
}

// MARK: UITableViewDataSource
extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel?.articles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleCell, for: indexPath)
        if (viewModel?.articles.isEmpty)! {
            return cell!
        } else {
            let data = viewModel?.articles[indexPath.row]
            let date = dateFormatter.date(from: data?.updatedAt ?? "2019-06-10")
            dateFormatter.dateFormat = "yyyy/MM/dd"
            cell?.dateLabel.text = dateFormatter.string(from: date ?? Date())
            cell?.titleLabel.text = data?.title
            var tagString = ""
            data?.tags.forEach({ (tag) in
                tagString.append(tag + " ")
            })
            cell?.tagsLabel.text = tagString
            return cell!
        }
    }
}

// MARK: UITableViewDelegate
extension ArticleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: UISearchBarDelegate
extension ArticleListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        viewModel?.resetResult()
        viewModel?.searchWord = searchBar.text ?? ""
        viewModel?.search()
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        viewModel?.resetResult()
        viewModel?.searchWord = searchBar.text ?? ""
        viewModel?.search()
    }
}


