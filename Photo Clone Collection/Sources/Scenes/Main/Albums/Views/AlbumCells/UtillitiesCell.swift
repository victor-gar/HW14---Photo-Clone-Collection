//
//  UtillitiesCell.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 13.03.2023.
//

import UIKit

final class UtilitiesCell: UICollectionViewListCell {
    
    static var cellID = "utilities"
    
    // MARK: UI
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var itemsCountTitle: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var divider: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.black
        return line
    }()
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(itemsCountTitle)
    }
    
    private func setupLayout() {
        icon.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.56)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.56)
            make.left.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10 / 2)
            make.right.equalToSuperview()
            make.height.centerY.equalTo(icon)
        }
        
        itemsCountTitle.snp.makeConstraints { make in
            make.height.centerY.equalToSuperview()
            make.width.equalTo(contentView.frame.height)
            make.right.equalTo(contentView).offset(10)
        }
    }
    
    private func addBottomDivider() {
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Configure cell with recieved data


}

