//
//  RepositoryListView.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit

// MARK: - List View Items

protocol RepositoryListViewDelegate {
    func onSelected()
}

protocol RepositoryListViewItem where Self: UIView {
    func render(_ viewModel: RepositoryListItemViewModel, delegate: RepositoryListViewDelegate?)
}

protocol RepositoryListView: AnyObject {
    func renderLoading()
    func finishLoading()
    func showError(error: Error)
    func render()
}
