//
//  UIViewController+Extensions.swift
//  PopularReposiOS
//
//  Created by Filip on 14/06/2021.
//

import UIKit

extension UIViewController {
    
    func showLoading() {
        let loadingSpinner = LoadingScreen()
        addChild(loadingSpinner)
        
        loadingSpinner.view.frame = view.frame
        view.addSubview(loadingSpinner.view)
        loadingSpinner.didMove(toParent: self)
    }
    
    func stopLoading() {
        guard let loadingSpinner = self.children.first else { return }
        
        loadingSpinner.willMove(toParent: nil)
        loadingSpinner.view.removeFromSuperview()
        loadingSpinner.removeFromParent()
    }
    
}

