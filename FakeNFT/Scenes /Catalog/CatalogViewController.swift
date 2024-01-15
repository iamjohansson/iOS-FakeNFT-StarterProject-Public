//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 14.01.24.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    lazy private var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(named: "sort"),
            style: .plain,
            target: self,
            action: #selector(showSortingMenu))
        return button
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(CatalogCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .ypWhite
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupConstraints()
        view.backgroundColor = .ypWhite
    }
    
    private func setupNavigationBar() {
        sortButton.tintColor = .ypBlack
        navigationController?.navigationBar.tintColor = .ypWhite
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func setupConstraints() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func showSortingMenu() {
        let alertMenu = UIAlertController(title: AppStrings.CatalogVC.sorting, message: nil, preferredStyle: .actionSheet)
        
        alertMenu.addAction(UIAlertAction(title: AppStrings.CatalogVC.sortByName, style: .default, handler: { [weak self] (UIAlertAction) in self
        }))
        alertMenu.addAction(UIAlertAction(title: AppStrings.CatalogVC.sortByNFTCount, style: .default, handler: { [weak self] (UIAlertAction) in self
        }))
        alertMenu.addAction(UIAlertAction(title: AppStrings.CatalogVC.close, style: .cancel))
        
        present(alertMenu, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CatalogCell = tableView.dequeueReusableCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        187
    }
}
