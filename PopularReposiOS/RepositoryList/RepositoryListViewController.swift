//
//  ViewController.swift
//  PopularReposiOS
//
//  Created by Filip on 14/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let repositoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var httpService = HttpService()
    private var loadingSpinner: LoadingScreen?
    
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

    var data: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        repositoryTableView.register(ResultItemCell.self, forCellReuseIdentifier: String(describing: ResultItemCell.self))
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
        httpService.get(endpoint: .searchRepositories, parameters:
                            ["q": "stars:300..310", "order": "desc", "sort":"stars"]) { (repos: RepositoriesResponseModel?, error: Error?) in
            
            self.stopLoading()
//            print(repos)
//            print(error)
            if let repos = repos {
                self.data = repos.items.map {
                    $0.name
                }
                self.repositoryTableView.reloadData()
            }
            
        }
    }
    
    

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultItemCell.self), for: indexPath) as? ResultItemCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "")
        }
        
        cell.update(text: data[indexPath.row])
        return cell
    }
    
    
}

