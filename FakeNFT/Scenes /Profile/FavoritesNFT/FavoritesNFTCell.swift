//
//  FavoritesNFTCell.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 30.01.2024.
//

import UIKit

// MARK: - Cell Delegate
protocol FavoritesNFTCellDelegate: AnyObject {
    func tapLike(cell: FavoritesNFTCell)
}

// MARK: - NFT Cell
final class FavoritesNFTCell: UICollectionViewCell {
    
    // MARK: Identifier
    static let identifier = "FavorNFTCell"
    
    // MARK: Properties & UI Elements
    weak var delegate: FavoritesNFTCellDelegate?
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = Constants.baseOffset12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: Constants.placeholderImage)
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
        label.text = Constants.nameText
        label.font = .sfProBold17
        return label
    }()
    
    private lazy var ratingView: DynamicRatingView = {
        let view = DynamicRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.priceText
        label.font = .sfProRegular15
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, ratingView, priceLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.setCustomSpacing(Constants.spacing4, after: nameLabel)
        stack.setCustomSpacing(Constants.spacing8, after: ratingView)
        stack.alignment = .leading
        return stack
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    // MARK: Methods
    func configure(nft: NFTModel) {
        if let imageURL = nft.images.first,
           let url = URL(string: imageURL) {
            image.kf.setImage(with: url)
        }
        
        nameLabel.text = nft.name
        ratingView.configureRating(nft.rating)
        priceLabel.text = "\(nft.price) \(Constants.currency)"
    }
    
    func configureLikeInCell(isLiked: Bool) {
        let imageName = isLiked ? Constants.like : Constants.unlike
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func addSubView() {
        [image, likeButton, stackView].forEach { addSubview($0) }
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            image.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            likeButton.topAnchor.constraint(equalTo: image.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: Constants.likeSize),
            likeButton.widthAnchor.constraint(equalToConstant: Constants.likeSize),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.baseOffset12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: Actions
    @objc private func didTapLikeButton() {
        delegate?.tapLike(cell: self)
    }
}

// MARK: - Constants
private extension FavoritesNFTCell {
    enum Constants {
        static let baseOffset12: CGFloat = 12
        static let imageSize: CGFloat = 80
        static let likeSize: CGFloat = 42
        static let spacing4: CGFloat = 4
        static let spacing8: CGFloat = 8
        
        static let placeholderImage = "photo.fill"
        static let nameText = "Name"
        static let priceText = "0,00"
        static let like = "likeActive"
        static let unlike = "likeNotActive"
        static let currency = "ETH"
    }
}
