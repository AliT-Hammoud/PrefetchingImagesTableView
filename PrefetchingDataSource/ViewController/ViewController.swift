//
//  ViewController.swift
//  PrefetchingDataSource
//
//  Created by Ali Hammoud on 25/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PhotoTableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.rowHeight = 300
        tableView.estimatedRowHeight = 300
        return tableView
    }()

    private let viewModels = Array(1...100).map {_ in ViewModel()}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        addConstaints()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
    
    private func addConstaints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! PhotoTableViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension ViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let viewModel = viewModels[indexPath.row]
            viewModel.downloadImage(completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //
    }
}
