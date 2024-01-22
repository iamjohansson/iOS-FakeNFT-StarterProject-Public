//
//  CatalogСollectionViewController.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 22.01.24.
//

import UIKit
import ProgressHUD

// MARK: - Protocol

protocol CatalogСollectionViewControllerProtocol: AnyObject {
    func renderViewData(viewData: CatalogCollectionViewData)
    func reloadCollectionView()
}

// MARK: - Final Class

final class CatalogСollectionViewController: UIViewController {
    
    private var heightConstraintCV = NSLayoutConstraint()
    
    private let itemsPerRow = 3
    private let bottomMargin: CGFloat = 55
    private let cellHeight: CGFloat = 172
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var coverImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor =  .ypBlack
        label.font = .sfProBold22
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = .sfProRegular13
        label.text = AppStrings.CollectionVC.authorInfo
        return label
    }()
    
    private lazy var authorLink: UILabel = {
        let label = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(launchWebsiteViewer))
        label.isUserInteractionEnabled = true
        label.font = .sfProRegular13
        label.textColor = .ypBlueUn
        label.backgroundColor = .ypWhite
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var collectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .sfProRegular13
        label.textColor = .ypBlack
        return label
    }()
    
    private lazy var nftCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.isScrollEnabled = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .ypWhite
        collection.register(NFTCollectionCell.self)
        return collection
    }()
    
    override func viewDidLoad() {
        setupConstraints()
        setupNavBackButton()
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        view.backgroundColor = .ypWhite
        
        scrollView.addSubview(contentView)
        
        [coverImageView, titleLabel, authorLabel, authorLink,
         collectionDescriptionLabel, nftCollection].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
            contentView.backgroundColor = .ypWhite
        }
        
        var topbarHeight: CGFloat {
            let statusBarHeight = navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
            let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
            return statusBarHeight + navigationBarHeight
        }
        
        heightConstraintCV = nftCollection.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -topbarHeight),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coverImageView.heightAnchor.constraint(equalToConstant: 310),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            authorLink.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLink.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 4),
            authorLink.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            authorLink.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 1),
            
            collectionDescriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nftCollection.topAnchor.constraint(equalTo: collectionDescriptionLabel.bottomAnchor, constant: 24),
            nftCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nftCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            heightConstraintCV
        ])
    }
    
    private func setupNavBackButton() {
        navigationController!.navigationBar.tintColor = .ypBlack
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "backward"),
            style: .plain,
            target: self,
            action: #selector(goBack))
    }
    
    private func calculateCollectionHeight(itemCount: Int) {
        // Вычисляем количество строк
        let numRows = (itemCount + itemsPerRow - 1) / itemsPerRow
        // Вычисляем высоту коллекции
        heightConstraintCV.constant = CGFloat(numRows) * cellHeight + bottomMargin
    }
    
    // MARK: - @objc func
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func launchWebsiteViewer() {
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CatalogСollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 108, height: 172)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

// MARK: - NFTCollectionCellDelegate

extension CatalogСollectionViewController: NFTCollectionCellDelegate {
    func onLikeButtonTapped(cell: NFTCollectionCell) {
    }
    
    
    func addToCartButtonTapped(cell: NFTCollectionCell) {
    }
}

// MARK: - CatalogСollectionViewControllerProtocol

extension CatalogСollectionViewController: CatalogСollectionViewControllerProtocol {
    func renderViewData(viewData: CatalogCollectionViewData) {
        <#code#>
    }
    
    func reloadCollectionView() {
        nftCollection.reloadData()
    }
}

