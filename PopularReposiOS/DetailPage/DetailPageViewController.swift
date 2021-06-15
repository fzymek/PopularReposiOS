//
//  DetailPageViewController.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit


class DetailPageViewController: UIViewController {
    
    var viewModel: RepositoryListItemViewModel?
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = viewModel?.name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        
        view.addSubview(label)
        NSLayoutConstraint.activate(
            [
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
}
