//
//  DetailPageDataProvider.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit

protocol DetailPageDataSource {
    var data: DetailPageViewModel? { get }
    func loadData()
    func beginUpdates()
    func finishUpdates()
}

enum DetailPageError: Error {
    case invalidData
}

class DetailPageDataProvider: DetailPageDataSource {
    
    var initialRepositoryViewModel: RepositoryListItemViewModel?
    weak var view: DetailPageView?
    private var detailPageData: DetailPageViewModel?
    
    var data: DetailPageViewModel? {
        return detailPageData
    }
    
    func loadData() {
        view?.renderLoading()
        guard let initialModel = initialRepositoryViewModel else {
            view?.finishLoading()
            view?.showError(error: DetailPageError.invalidData)
            return
        }
        
        self.detailPageData = createViewModel(from: initialModel)
        view?.finishLoading()
        view?.render()
        
    }
    
    func createViewModel(from repositoryViewModel: RepositoryListItemViewModel) -> DetailPageViewModel? {
        return DetailPageViewModel(from: repositoryViewModel)
    }
    
    func beginUpdates() {
        
    }
    
    func finishUpdates() {
    }
    
}
