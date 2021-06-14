//
//  LoadingScreen.swift
//  PopularReposiOS
//
//  Created by Filip on 14/06/2021.
//

import UIKit

class LoadingScreen: UIViewController {
    private let loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = UIColor(white: 0, alpha: 0.65)
        
        view.addSubview(loadingSpinner)
        NSLayoutConstraint.activate(
            [
                loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
        loadingSpinner.startAnimating()
    }
}
