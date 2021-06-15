//
//  Views.swift
//  PopularReposiOS
//
//  Created by Filip on 15/06/2021.
//

import UIKit

protocol DetailPageView: AnyObject {
    func renderLoading()
    func finishLoading()
    func showError(error: Error)
    func render()
}
