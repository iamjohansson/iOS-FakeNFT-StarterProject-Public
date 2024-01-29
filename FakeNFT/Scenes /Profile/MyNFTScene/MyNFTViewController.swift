//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 27.01.2024.
//

import UIKit

// MARK: - ViewController Protocol
protocol MyNFTViewProtocol: AnyObject {
    func update(with nfts: [NFTModel])
}

// MARK: - ViewController
final class MyNFTViewController: UIViewController {
    
    // MARK: Properties & UI Elements
    private lazy var placeholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sfProBold17
        label.textColor = .ypBlack
        label.text = "У Вас ещё нет NFT"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .ypWhite
        table.delegate = self
        table.dataSource = self
        table.register(MyNFTCell.self, forCellReuseIdentifier: MyNFTCell.identifier)
        return table
    }()
    
    private var presenter: MyNFTViewPresenter?
    private var nftModel: [NFTModel] = []
    private var likedNFT: [String]
    private var nftId: [String]
    
    // MARK: Lifecycle
    init(likedNFT: [String], nftId: [String]) {
        self.likedNFT = likedNFT
        self.nftId = nftId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        self.likedNFT = []
        self.nftId = []
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setupNavBar()
        addSubview()
        applyConstraint()
        setupPresenter()
    }
    
    // MARK: Methods
    private func setupPresenter() {
        let nw = DefaultNetworkClient()
        let storage = ProfileStorage()
        let profileService = ProfileService(networkClient: nw, storage: storage)
        presenter = MyNFTViewPresenter(likedNFT: self.likedNFT, nftId: self.nftId, profileService: profileService)
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(didTapExitButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "filter"),
            style: .plain,
            target: self,
            action: #selector(didTapFilterButton)
        )
        navigationItem.title = "Мои NFT"
        navigationController?.navigationBar.tintColor = .ypBlack
    }
    
    private func addSubview() {
        [placeholder, tableView].forEach { view.addSubview($0) }
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Actions
    @objc private func didTapExitButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapFilterButton() {
        let alert = UIAlertController(
            title: nil,
            message: "Сортировка",
            preferredStyle: .actionSheet
        )
        let priceAction = UIAlertAction(title: "По цене", style: .default, handler: { _ in
            self.presenter?.filterNFT(type: .price)
        })
        alert.addAction(priceAction)
        let ratingAction = UIAlertAction(title: "По рейтингу", style: .default, handler: { _ in
            self.presenter?.filterNFT(type: .rating)
        })
        alert.addAction(ratingAction)
        let nameAction = UIAlertAction(title: "По названию", style: .default, handler: { _ in
            self.presenter?.filterNFT(type: .name)
        })
        alert.addAction(nameAction)
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource & Delegate protocols
extension MyNFTViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRow = presenter?.nftModel.count else { return 0 }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNFTCell.identifier,
            for: indexPath) as? MyNFTCell else { return UITableViewCell() }
        if let nft = presenter?.nftModel[indexPath.row] {
            cell.delegate = self
            cell.configureCell(nft: nft)
            
            let isLiked = presenter?.isLiked(nft: nft.id) ?? false
            cell.configureLikeInCell(isLiked: isLiked)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
// MARK: - NFTView Protocol
extension MyNFTViewController: MyNFTViewProtocol {
    func update(with nfts: [NFTModel]) {
        self.nftModel = nfts
        DispatchQueue.main.async {
            let isNFTsEmpty = self.nftModel.isEmpty
            self.placeholder.isHidden = !isNFTsEmpty
            self.tableView.reloadData()
        }
    }
}

// MARK: - Cell Delegate
extension MyNFTViewController: MyNFTCellDelegate {
    func changeLike(for id: String) {
        guard let presenter = self.presenter else { return }
        presenter.toggleLike(id: id)
        
        if let index = presenter.nftModel.firstIndex(where: { $0.id == id }) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

