//
//  OverviewCell.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 26.03.2023.
//

import UIKit

final class OverviewCell: UICollectionViewCell, Highlightable {
    
    static var cellID = "overview"
    
    // MARK: - UI
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.title
        return label
    }()
    
    // MARK: - UI: If people cell type
    
    private lazy var firstPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var secondPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var thirdPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var fourthPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var peopleIcons: [UIImageView] = {
        [firstPersonImage,
         secondPersonImage,
         thirdPersonImage,
         fourthPersonImage]
    }()
    
    // MARK: - UI: If places cell type
    
    private lazy var largeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageForBothStates(image: "mapSnapShot")
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var smallImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageForBothStates(image: "emptyAlbum", border: .white)
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var itemsCountTitle: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemGray
        label.font = Constants.Fonts.subtitle
        return label
    }()

    // MARK: - Setups if people cell type
    
    private func setupPeopleCell(with images: [String]) {
        if images.count == 4 {
            for (i, name) in images.enumerated() {
                peopleIcons[i].setupImageForBothStates(image: name)
            }
        }
        
        itemTitle.text = "People"
        
        setupPeopleCellHierarchy()
        setupPeopleCellLayout()
    }
    
    private func setupPeopleCellHierarchy() {
        peopleIcons.forEach { addSubview($0) }
        addSubview(itemTitle)
    }
    
    private func setupPeopleCellLayout() {
        let width = contentView.frame.width
        let edge = width / 2
        
        peopleIcons.forEach { $0.setupAsIcon(edge: edge); $0.frame.size = CGSize(width: edge, height: edge) }
        
        firstPersonImage.frame.origin = .zero
        secondPersonImage.frame.origin = CGPoint(x: .zero, y: edge)
        thirdPersonImage.frame.origin = CGPoint(x: edge, y: edge)
        fourthPersonImage.frame.origin = CGPoint(x: edge, y: .zero)
        
        itemTitle.frame = CGRect(x: 0, y: width,
                                 width: width, height: (contentView.frame.height - width) / 2)
    }
    
    // MARK: - Setups if places cell type
    
    private func setupPlacesCell(with images: [String], count: Int) {
        if images.count == 2 {
            largeImage.setupImageForBothStates(image: images[0])
            smallImage.setupImageForBothStates(image: images[1])
        }
        
        itemsCountTitle.text = "\(count > 0 ? count : 0)"
        itemTitle.text = "Places"
        
        setupPlacesCellHierarchy()
        setupPlacesCellLayout()
    }
    
    private func setupPlacesCellHierarchy() {
        addSubview(largeImage)
        addSubview(smallImage)
        addSubview(itemTitle)
        addSubview(itemsCountTitle)
    }
    
    private func setupPlacesCellLayout() {
        largeImage.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        smallImage.snp.makeConstraints { make in
            make.center.equalTo(largeImage)
            make.size.equalTo(largeImage).multipliedBy(0.6)
        }
        
        itemTitle.snp.makeConstraints { make in
            make.top.equalTo(largeImage.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(itemsCountTitle.snp.top)
        }
        
        itemsCountTitle.snp.makeConstraints { make in
            make.height.equalTo(itemTitle)
            make.width.centerX.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configure cell with recieved data
    
    public func configure(type: String, images: [String], count: Int = 0) {
        if type == "People" {
            setupPeopleCell(with: images)
        } else if type == "Places" {
            setupPlacesCell(with: images, count: count)
        }
    }
    
    // MARK: - Cell when selected
    
    func highlight() {
        peopleIcons.forEach { $0.isHighlighted = true }
        largeImage.isHighlighted = true
        smallImage.isHighlighted = true
        smallImage.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
    }
    
    func unhighlight() {
        peopleIcons.forEach { $0.isHighlighted = false }
        smallImage.isHighlighted = false
        smallImage.layer.borderColor = UIColor.white.cgColor
        largeImage.isHighlighted = false
    }
}
