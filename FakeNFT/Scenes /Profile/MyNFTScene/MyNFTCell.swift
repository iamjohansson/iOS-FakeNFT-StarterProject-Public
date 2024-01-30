//
//  MyNFTCell.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 27.01.2024.
//

import UIKit
import Kingfisher

// MARK: - Cell Delegate
protocol MyNFTCellDelegate: AnyObject {
    func changeLike(for id: String)
}

// MARK: - NFT Cell
final class MyNFTCell: UITableViewCell {
    
    // MARK: Identifier
    static let identifier = "NFTCell"
    
    // MARK: Properties & UI Elements
    weak var delegate: MyNFTCellDelegate?
    
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
    
    private lazy var ratingView: DynamicRatingView = {
        let view = DynamicRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Admin"
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
    
    private lazy var middleStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 2
        stack.axis = .vertical
        return stack
    }()
    
    private var idNft: String?
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .ypWhite
        addSubView()
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    // MARK: Methods
    func configureCell(nft: NFTModel) {
        self.idNft = nft.id
        
        if let imageURL = nft.images.first,
           let url = URL(string: imageURL) {
            image.kf.setImage(with: url)
        }
        
        nameLabel.text = nft.name
        ratingView.configureRating(nft.rating)
        ownerLabel.text = "От" + " " + (nft.authorName ?? "Admin")
        priceLabel.text = "\(nft.price) ETH"
    }
    func configureLikeInCell(isLiked: Bool) {
        let imageName = isLiked ? "likeActive" : "likeNotActive"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func addSubView() {
        [nameLabel, ratingView, ownerLabel].forEach { middleStack.addArrangedSubview($0) }
        [priceNameLabel, priceLabel].forEach { rightStack.addArrangedSubview($0) }
        [image, likeButton, middleStack, rightStack].forEach { contentView.addSubview($0) }
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.baseOffset16),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.baseOffset16),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.baseOffset16),
            image.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            image.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            likeButton.topAnchor.constraint(equalTo: image.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: Constants.likeSize),
            likeButton.widthAnchor.constraint(equalToConstant: Constants.likeSize),
            middleStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            middleStack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.baseOffset20),
            rightStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightStack.leadingAnchor.constraint(equalTo: middleStack.trailingAnchor, constant: Constants.baseOffset39)
        ])
    }
    
    // MARK: Actions
    @objc private func didTapLikeButton() {
        if let id = idNft {
            delegate?.changeLike(for: id)
        }
    }
}

// MARK: - Constants
private extension MyNFTCell {
    enum Constants {
        static let baseOffset16: CGFloat = 16
        static let baseOffset20: CGFloat = 20
        static let baseOffset39: CGFloat = 39
        static let imageSize: CGFloat = 108
        static let likeSize: CGFloat = 42
    }
}
