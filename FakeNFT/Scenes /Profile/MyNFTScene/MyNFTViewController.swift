//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 27.01.2024.
//

import UIKit
import ProgressHUD

// MARK: - ViewController Protocol
protocol MyNFTViewProtocol: AnyObject {
    func update(with nfts: [NFTModel])
    func showError(error: Error)
    func showSuccess(isLike: Bool)
}

// MARK: - ViewController
final class MyNFTViewController: UIViewController {
    
    // MARK: Properties & UI Elements
    private lazy var placeholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sfProBold17
        label.textColor = .ypBlack
        label.text = UIConstants.placeholder
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
            image: UIImage(systemName: UIConstants.backButtonImage),
            style: .plain,
            target: self,
            action: #selector(didTapExitButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: UIConstants.filterImage),
            style: .plain,
            target: self,
            action: #selector(didTapFilterButton)
        )
        navigationItem.title = UIConstants.title
        navigationController?.navigationBar.tintColor = .ypBlack
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.sfProBold17 ?? UIFont.systemFont(ofSize: 17)
             ]
        navigationController?.navigationBar.titleTextAttributes = [
             NSAttributedString.Key.foregroundColor: UIColor.ypBlack
         ]
    }
    
    private func addSubview() {
        [tableView, placeholder].forEach { view.addSubview($0) }
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.inset20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: Actions
    @objc private func didTapExitButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapFilterButton() {
        let alert = UIAlertController(
            title: nil,
            message: SortConstants.message,
            preferredStyle: .actionSheet
        )
        let priceAction = UIAlertAction(title: SortConstants.price, style: .default, handler: { _ in
            self.presenter?.filterNFT(type: .price)
        })
        alert.addAction(priceAction)
        let ratingAction = UIAlertAction(title: SortConstants.rating, style: .default, handler: { _ in
            self.presenter?.filterNFT(type: .rating)
        })
        alert.addAction(ratingAction)
        let nameAction = UIAlertAction(title: SortConstants.name, style: .default, handler: { _ in
            self.presenter?.filterNFT(type: .name)
        })
        alert.addAction(nameAction)
        let cancelAction = UIAlertAction(title: SortConstants.cancel, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource & Delegate protocols
extension MyNFTViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRow = presenter?.nftModel.count else { return UIConstants.zero }
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
        return UIConstants.heightRow
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
    
    func showError(error: Error) {
        ProgressHUD.showError("Ошибка - \(error.localizedDescription)", delay: 1.5)
    }
    
    func showSuccess(isLike: Bool) {
        let like = isLike 
        if like {
            ProgressHUD.showSuccess("Добавлено в избранное", image: UIImage(systemName: "heart.fill"))
        } else {
            ProgressHUD.showSuccess("Удалено из избранного", image: UIImage(systemName: "heart"))
        }
    }
}

// MARK: - Cell Delegate
extension MyNFTViewController: MyNFTCellDelegate {
    func changeLike(for id: String) {
        guard let presenter = self.presenter else { return }
        presenter.toggleLike(id: id)
        
        if let index = presenter.nftModel.firstIndex(where: { $0.id == id }) {
            let indexPath = IndexPath(row: index, section: UIConstants.zero)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Constants
private extension MyNFTViewController {
    enum UIConstants {
        static let placeholder = "У Вас ещё нет NFT"
        static let backButtonImage = "chevron.backward"
        static let filterImage = "filter"
        static let title = "Мои NFT"
        static let inset20: CGFloat = 20
        static let heightRow: CGFloat = 140
        static let zero: Int = 0
    }
    
    enum SortConstants {
        static let message = "Сортировка"
        static let price = "По цене"
        static let rating = "По рейтингу"
        static let name = "По названию"
        static let cancel = "Закрыть"
    }
}
