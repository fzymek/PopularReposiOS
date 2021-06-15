//
//  ViewModels.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import Foundation

struct DetailPageViewModel {
    let repositoryName: String
    let numberOfStarsText: String
    let ownerName: String
    let language: String
    let forkText: String
    
    init(from model: RepositoryListItemViewModel) {
        self.repositoryName = model.name
        self.numberOfStarsText = "Current stars count: \(model.numberOfStars)"
        self.ownerName = "Repository owner: \(model.owner)"
        self.language = "Main repository language: \(model.language ?? "Unspecified")"
        self.forkText = model.isFork ? "This repository is a fork. " : "This repository is not a fork."
    }
}
