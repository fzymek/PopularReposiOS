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

    let data = ["a", "b", "c", "d", "e", "f", "g"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        repositoryTableView.register(ResultItemCell.self, forCellReuseIdentifier: String(describing: ResultItemCell.self))
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
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

