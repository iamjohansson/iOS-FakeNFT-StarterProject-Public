//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 13.01.24.
//

import UIKit

final class CatalogCell: UITableViewCell, ReuseIdentifying {

    lazy var catalogCellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var catalogNameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .ypBlack
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }

    func setupUI() {
        contentView.addSubview(catalogCellImage)
        contentView.addSubview(catalogNameLabel)
        contentView.backgroundColor = .ypWhite
        
        NSLayoutConstraint.activate([
            catalogCellImage.heightAnchor.constraint(equalToConstant: 140),
            catalogCellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            catalogCellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            catalogCellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            catalogNameLabel.topAnchor.constraint(equalTo: catalogCellImage.bottomAnchor, constant: 4),
            catalogNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
