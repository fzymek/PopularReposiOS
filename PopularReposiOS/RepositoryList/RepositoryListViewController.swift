//
//  ViewController.swift
//  PopularReposiOS
//
//  Created by Filip on 14/06/2021.
//

import UIKit

class RepositoryListViewController: UIViewController, RepositoryListView {
    
    var dataProvider: RepositoryListDataProvider?
    
    private let repositoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func loadView() {
        let view = UIView()
        self.view = view
        
        view.addSubview(repositoryTableView)
        NSLayoutConstraint.activate(
            [
                repositoryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                repositoryTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: repositoryTableView.bottomAnchor),
                view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: repositoryTableView.trailingAnchor)
            ]
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerWidgets()
        repositoryTableView.dataSource = self
        repositoryTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataProvider = RepositoryListDataProvider(view: self)
        dataProvider?.startLoading()
    }
    
    //MARK: - RepositoryListView
    
    func registerWidgets() {
        repositoryTableView.register(ResultItemCell.self, forCellReuseIdentifier: String(describing: ResultItemCell.self))
    }
    
    func renderLoading() {
        showLoading()
    }
    
    func finishLoading() {
        stopLoading()
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Unexpected error happened. Please ty again later. Details: \(error.localizedDescription)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func render() {
        repositoryTableView.reloadData()
    }

}

extension RepositoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultItemCell.self)) as? ResultItemCell,
              let model = dataProvider?.item(at: indexPath) else {
            return UITableViewCell()
        }
        
        cell.render(model, delegate: self)
        
        return cell
    }
    
}

extension RepositoryListViewController: UITableViewDelegate {
    
}

extension RepositoryListViewController: RepositoryListViewDelegate {
    func onSelected() {
        
    }
}
