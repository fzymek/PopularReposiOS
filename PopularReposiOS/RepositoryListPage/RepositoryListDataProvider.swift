//
//  RepositoryListDataProvider.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit

protocol RepositoryListDataSource {
    func startLoading()    
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
    
    func startLoading() {
        view?.renderLoading()
        
        restService.get(endpoint: .searchRepositories,
                        parameters:
                            [
                                "q": "stars:300..310",
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
    }
    
    func buildViewModel(_ data: RepositorySearchResponse) -> RepositoryListViewModel {
        let items = data.items.map {
            return RepositoryListItemViewModel($0)
        }
        return RepositoryListViewModel(items: items)
    }
    
    func item(at indexPath: IndexPath) -> RepositoryListItemViewModel? {
        guard let item = data?.items[indexPath.row] else {
            return nil
        }
        
        return RepositoryListItemViewModel(item)
    }
    
}
