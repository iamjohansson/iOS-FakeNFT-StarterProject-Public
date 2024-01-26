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
    
    private var nftModel: Nft?
    private var profileModel: ProfileModel?
    
    private var likedByUser: Bool = false
    private var itemInCart: Bool = false
    
    weak var delegate: NFTCollectionCellDelegate?
    
    private lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.imageView?.tintColor = .ypRedUn
        button.addTarget(self, action: #selector(userDidLike), for: .touchUpInside)
        button.setImage(UIImage(named: "likeNotActive"), for: .normal)
        
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addToCart"), for: .normal)
        button.addTarget(self, action: #selector(cartItemAdded), for: .touchUpInside)
        return button
    }()
    
    private lazy var ratingStarsView: DynamicRatingView = {
        let view = DynamicRatingView()
        return view
    }()
    
    private lazy var nftNameAndPriceView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var nftName: UILabel = {
        let label = UILabel()
        label.text = "nftName"
        label.font = .sfProBold17
        return label
    }()
    
    private lazy var nftPrice: UILabel = {
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
            likeButton.topAnchor.constraint(equalTo: nftImage.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 42),
            likeButton.heightAnchor.constraint(equalToConstant: 42),
            
            // ratingStarsView
            ratingStarsView.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 8),
            ratingStarsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingStarsView.heightAnchor.constraint(equalToConstant: 12),
            ratingStarsView.widthAnchor.constraint(equalToConstant: 68),
            
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
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setNftModel(_ model: Nft?) {
        nftModel = model
    }
    
    func getNftModel() -> Nft? {
        return nftModel
    }
    
    func getProfileModel() -> ProfileModel? {
        return profileModel
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
    
    internal func configureLikeButtonImage() {
        likedByUser.toggle()
        let likeName = likedByUser ? "likeActive" : "likeNotActive"
        likeButton.setImage(UIImage(named: likeName), for: .normal)
    }
    
    internal func configureCartButtonImage() {
        itemInCart.toggle()
        let cartImage = itemInCart ? "addToCart" : "deleteFromCart"
        cartButton.setImage(UIImage(named: cartImage), for: .normal)
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
