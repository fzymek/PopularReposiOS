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
    private let repo: RepositoryModel
    
    init(_ repositoryModel: RepositoryModel) {
        self.repo = repositoryModel
    }

    var name: String {
        repo.name
    }
}
