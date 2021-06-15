//
//  ViewModel.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import Foundation

struct RepositoryListViewModel {
    let items: [RepositoryListItemViewModel]
}

struct RepositoryListItemViewModel {
    private let repo: Repository
    
    init(_ repositoryModel: Repository) {
        self.repo = repositoryModel
    }

    var name: String {
        repo.name
    }
    
    var owner: String {
        repo.owner.login
    }
    
    var numberOfStars: Int {
        repo.starCount
    }
    
    var isFork: Bool {
        repo.isFork
    }
    
    var language: String? {
        repo.language
    }
        
}
