//
//  RepositoryListDataProvider.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit

protocol RepositoryListDataSource {
    func startLoading()
    func startLoading(isRefreshing: Bool)
    func item(at indexPath: IndexPath) -> RepositoryListItemViewModel?
}

enum RepositoryDataProviderError: Error {
    case unexpectedError
}

class RepositoryListDataProvider: RepositoryListDataSource {
    
    weak var view: RepositoryListView?
    var data: RepositorySearchResponse?
    
    var numberOfItems: Int {
        data?.items.count ?? 0
    }
    
    lazy var restService: HttpService = GithubRESTService.shared
    
    init(view: RepositoryListView) {
        self.view = view
    }
    
    func startLoading(isRefreshing: Bool) {
        view?.renderLoading(isRefreshing: isRefreshing)
        
        let task = restService.get(endpoint: Endpoint.searchRepositiries(),
                                    parameters:
                                        [
                                            "q": "stars:>0",
                                            "sort": "stars",
                                            "order": "desc"
                                        ]) { (resp: RepositorySearchResponse?, error: Error?) in
            self.view?.finishLoading()
            if let err = error {
                self.view?.showError(error: err)
                return
            }
            
            if let resp = resp {
                self.data = resp
                self.view?.render()
            }
        }
        
        guard let dataTask = task else {
            view?.finishLoading()
            view?.showError(error: RepositoryDataProviderError.unexpectedError)
            return
        }
        
        dataTask.resume()
    }
    
    func startLoading() {
        startLoading(isRefreshing: false)
    }
    
    func item(at indexPath: IndexPath) -> RepositoryListItemViewModel? {
        guard let item = data?.items[indexPath.row] else {
            return nil
        }
        
        return RepositoryListItemViewModel(item)
    }
    
}
