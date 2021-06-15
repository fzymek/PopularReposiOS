//
//  DetailPageViewController.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit

enum DetailPageViewError: Error {
    case unexpectedError
}

class DetailPageViewController: UIViewController, DetailPageView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let forkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var dataSource: DetailPageDataSource?
    
    override func loadView() {
        self.view = UIView()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(titleLabel)
        view.addSubview(ownerLabel)
        view.addSubview(starsLabel)
        view.addSubview(languageLabel)
        view.addSubview(forkLabel)
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                view.trailingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
                
                ownerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                ownerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                view.trailingAnchor.constraint(greaterThanOrEqualTo: ownerLabel.trailingAnchor, constant: 8),
                
                starsLabel.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor, constant: 4),
                starsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                view.trailingAnchor.constraint(greaterThanOrEqualTo: starsLabel.trailingAnchor, constant: 8),
                
                languageLabel.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: 4),
                languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                view.trailingAnchor.constraint(greaterThanOrEqualTo: languageLabel.trailingAnchor, constant: 8),
                
                forkLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 4),
                forkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                view.trailingAnchor.constraint(greaterThanOrEqualTo: forkLabel.trailingAnchor, constant: 8),
                view.bottomAnchor.constraint(greaterThanOrEqualTo: forkLabel.bottomAnchor, constant: 12)
            ]
        )
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource?.loadData()
        dataSource?.beginUpdates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataSource?.finishUpdates()
    }
    
    //MARK: - DetailPageView
    
    func renderLoading() {
        showLoading()
    }
    
    func finishLoading() {
        stopLoading()
    }
    
    func showError(error: Error) {
        showDefaultErrorMessage(error: error)
    }
    
    func render() {
        guard let model = dataSource?.data else {
            showError(error: DetailPageViewError.unexpectedError)
            return
        }
        
        titleLabel.text = model.repositoryName
        ownerLabel.text = model.ownerName
        starsLabel.text = model.numberOfStarsText
        languageLabel.text = model.language
        forkLabel.text = model.forkText
    }
    
}
