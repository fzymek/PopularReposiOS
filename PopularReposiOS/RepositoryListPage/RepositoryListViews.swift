//
//  RepositoryListView.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit

// MARK: - List View Items

protocol RepositoryListViewItem: AnyObject {
    func render(_ viewModel: RepositoryListItemViewModel)
}

protocol RepositoryListView: AnyObject {
    func renderLoading()
    func finishLoading()
    func showError(error: Error)
    func render()
}
