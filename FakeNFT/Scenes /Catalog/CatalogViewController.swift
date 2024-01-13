//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 14.01.24.
//

import UIKit

final class CatalogViewController: UIViewController {
    private let reuseIdentifier = "CatalogCell"
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .ypWhite
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}
