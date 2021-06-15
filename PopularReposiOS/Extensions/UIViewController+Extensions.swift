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
    
    func showDefaultErrorMessage(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Unexpected error happened. Please ty again later. Details: \(error.localizedDescription)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

