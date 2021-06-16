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
    
    lazy var restService: HttpService = GithubRESTService.shared
    private var detailPageData: DetailPageViewModel?
    private var updateTask: URLSessionDataTask?
    private var timer: Timer?
    
    var data: DetailPageViewModel? {
        return detailPageData
    }
    
    func loadData() {
        view?.renderLoading()
        runUpdateTask()
    }
    
    func beginUpdates() {
        guard let _ = timer, let _ = updateTask else {
            //we have timer or task running, do notihng
            return
        }
        
        configureTimer()
    }
    
    func beginUpdates(startOver: Bool) {
        if startOver {
            timer?.invalidate()
            timer = nil
            updateTask?.cancel()
            updateTask = nil
        }
        configureTimer()
    }
    
    func finishUpdates() {
        if let currentTask = updateTask {
            currentTask.cancel()
            updateTask = nil
        }
        
        if let currentTimer = timer {
            currentTimer.invalidate()
            timer = nil
        }
    }
    
    @objc func runUpdateTask() {
        guard let model = initialRepositoryViewModel, updateTask == nil else {
            //do not update in case of invalid input
            return
        }
        
        
        self.updateTask = restService.get(endpoint: Endpoint.repositoryEndpoint(owner: model.owner, name: model.name), parameters: [:]) { (repo: Repository?, error: Error?) in
            self.view?.finishLoading()
            if let err = error {
                self.view?.showError(error: err)
                return
            }
            
            if let repo = repo {
                self.detailPageData = DetailPageViewModel(from: repo)
                self.view?.render()
                self.beginUpdates(startOver: true)
            }
        }
        
        self.updateTask?.resume()
    }
    
    private func configureTimer() {
        timer = Timer.scheduledTimer(timeInterval: 10,
                                     target: self,
                                     selector: #selector(runUpdateTask), userInfo: nil,
                                     repeats: false)
    }
    
}
