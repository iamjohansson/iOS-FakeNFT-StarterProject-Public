//
//  MyNFTCell.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 27.01.2024.
//

import UIKit

final class MyNFTCell: UITableViewCell {
    
    // MARK: - Properties & UI Elements
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "photo.fill")
        return image
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = .sfProBold17
        return label
    }()
    
    // TODO: UI Rating
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Owner"
        label.numberOfLines = 0
        label.font = .sfProRegular13
        return label
    }()
    
    private lazy var priceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цена"
        label.font = .sfProRegular13
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .sfProBold17
        return label
    }()
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    // MARK: Methods
    private func addSubView() {
        
    }
    
    private func applyConstraint() {
        
    }
    
    // MARK: Actions
    @objc private func didTapLikeButton() {
        // TODO: обработка лукаса
    }
}

