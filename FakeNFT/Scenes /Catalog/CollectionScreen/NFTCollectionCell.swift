//
//  NFTCollectionCell.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 20.01.24.
//

import UIKit
// MARK: - Protocol

protocol NFTCollectionCellDelegate: AnyObject {
    func onLikeButtonTapped(cell: NFTCollectionCell)
    func addToCartButtonTapped(cell: NFTCollectionCell)
}

// MARK: - Final Class

final class NFTCollectionCell: UICollectionViewCell, ReuseIdentifying {
    
    var nftModel: Nft?//todo: private
    
    private var likedByUser: Bool = false
    private var itemInCart: Bool = false
    
    weak var delegate: NFTCollectionCellDelegate?
    
    lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .ypRedUn
        button.addTarget(self, action: #selector(userDidLike), for: .touchUpInside)
        button.setImage(UIImage(named: "likeNotActive"), for: .normal)
        
        return button
    }()
    
    lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addToCart"), for: .normal)
        button.addTarget(self, action: #selector(cartItemAdded), for: .touchUpInside)
        return button
    }()
    
    lazy var ratingStarsView: DynamicRatingView = {
        let view = DynamicRatingView()
        return view
    }()
    
    lazy var nftNameAndPriceView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nftName: UILabel = {
        let label = UILabel()
        label.text = "nftName"
        label.font = .sfProBold17
        return label
    }()
    
    lazy var nftPrice: UILabel = {
        let label = UILabel()
        label.text = "1 ETH"
        label.font = .sfProLight10
        return label
    }()
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    private func setupCellUI() {
        [nftImage, likeButton, ratingStarsView, cartButton, nftNameAndPriceView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        [nftName, nftPrice].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            nftNameAndPriceView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            // ImageView
            nftImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImage.heightAnchor.constraint(equalToConstant: 108),
            
            // LikeButton
            likeButton.topAnchor.constraint(equalTo: nftImage.topAnchor, constant: 12),
            likeButton.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: -12),
            likeButton.widthAnchor.constraint(equalToConstant: 26),
            likeButton.heightAnchor.constraint(equalToConstant: 22),
            
            // ratingStarsView
            ratingStarsView.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 8),
            ratingStarsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingStarsView.widthAnchor.constraint(equalToConstant: 70),
            
            nftNameAndPriceView.topAnchor.constraint(equalTo: ratingStarsView.bottomAnchor, constant: 4),
            nftNameAndPriceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftNameAndPriceView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.63),
            nftNameAndPriceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // NFTName
            nftName.topAnchor.constraint(equalTo: nftNameAndPriceView.topAnchor),
            nftName.leadingAnchor.constraint(equalTo: nftNameAndPriceView.leadingAnchor),
            nftName.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndPriceView.trailingAnchor),
            
            // NFTPrice
            nftPrice.bottomAnchor.constraint(equalTo: nftNameAndPriceView.bottomAnchor),
            nftPrice.leadingAnchor.constraint(equalTo: nftNameAndPriceView.leadingAnchor),
            nftPrice.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndPriceView.trailingAnchor),
            
            // Cart
            cartButton.centerYAnchor.constraint(equalTo: nftNameAndPriceView.centerYAnchor),
            cartButton.leadingAnchor.constraint(greaterThanOrEqualTo: nftNameAndPriceView.trailingAnchor),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func renderCellForModel() {
        guard let nftModel = nftModel else { return }
        
        if let imageURL = nftModel.images.first {
            nftImage.kf.setImage(with: imageURL)
        }
        
        nftName.text = nftModel.name
        nftPrice.text = "\(nftModel.price) ETH"
        ratingStarsView.configureRating(nftModel.rating)
    }
    
    private func configureLikeButtonImage() {
        if likedByUser {
            likedByUser = false
            likeButton.setImage(UIImage(named: "likeNotActive"), for: .normal)
        } else {
            likedByUser = true
            likeButton.setImage(UIImage(named: "likeActive"), for: .normal)
        }
    }
    
    private func configureCartButtonImage() {
        if itemInCart {
            itemInCart = false
            cartButton.setImage(UIImage(named: "addToCart"), for: .normal)
        } else {
            itemInCart = true
            cartButton.setImage(UIImage(named: "deleteFromCart"), for: .normal)
        }
    }
    
    // MARK: - @objc func
    
    @objc func userDidLike() {
        configureLikeButtonImage()
        delegate?.onLikeButtonTapped(cell: self)
    }
    
    @objc func cartItemAdded() {
        configureCartButtonImage()
        delegate?.addToCartButtonTapped(cell: self)
    }
}
