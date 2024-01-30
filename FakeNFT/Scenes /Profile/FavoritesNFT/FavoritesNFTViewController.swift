//
//  FavoritesNFTViewController.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 30.01.2024.
//

import UIKit

// MARK: - ViewController
final class FavoritesNFTViewController: UIViewController {
    
    // MARK: Properties & UI Elements
    private lazy var placeholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sfProBold17
        label.textColor = .ypBlack
        label.text = Constants.placeholder
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .ypWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoritesNFTCell.self, forCellWithReuseIdentifier: FavoritesNFTCell.identifier)
        return collectionView
    }()
    
    private var presenter: FavoritesNFTViewPresenter?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setupNavBar()
        addSubView()
        applyConstraint()
    }
    
    // MARK: Methods
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.backButtonImage),
            style: .plain,
            target: self,
            action: #selector(didTapExitButton)
        )
        navigationItem.title = Constants.title
        navigationController?.navigationBar.tintColor = .ypBlack
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.sfProBold17 ?? UIFont.systemFont(ofSize: 17)
             ]
        navigationController?.navigationBar.titleTextAttributes = [
             NSAttributedString.Key.foregroundColor: UIColor.ypBlack
         ]
    }
    
    private func addSubView() {
        [placeholder, collectionView].forEach { view.addSubview($0) }
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func didTapExitButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollection DataSource
extension FavoritesNFTViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        // TODO: Количество NFTs
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard 
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FavoritesNFTCell.identifier,
                for: indexPath
            ) as? FavoritesNFTCell else { return UICollectionViewCell() }
        
        // TODO: Конфигурируем ячейку, на прием забираем nft
        return cell
    }
}

// MARK: - UICollection DelegateFlowLayout
extension FavoritesNFTViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: GeometricParams.topInset,
            left: GeometricParams.leftInset,
            bottom: GeometricParams.botInset,
            right: GeometricParams.rightInset
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - GeometricParams.interitemSpacing - GeometricParams.leftInset - GeometricParams.rightInset) / GeometricParams.cellCount
        return CGSize(width: itemWidth, height: GeometricParams.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return GeometricParams.interitemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GeometricParams.lineSpacing
    }
}

// MARK: - Constants
private extension FavoritesNFTViewController {
    enum Constants {
        static let title = "Избранные NFT"
        static let backButtonImage = "chevron.backward"
        static let placeholder = "У Вас ещё нет избранных NFT"
    }
    
    enum GeometricParams {
        static let interitemSpacing: CGFloat = 7
        static let lineSpacing: CGFloat = 20
        static let leftInset: CGFloat = 16
        static let rightInset: CGFloat = 16
        static let topInset: CGFloat = 20
        static let botInset: CGFloat = 0
        static let cellCount: CGFloat = 2
        static let cellHeight: CGFloat = 80
    }
}
