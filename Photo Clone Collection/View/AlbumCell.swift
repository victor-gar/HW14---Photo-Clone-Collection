//
//  AlbumCell.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 01.02.2023.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    
    static var cellID = "album"
    
    // MARK: - Oulets
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.contentMode = .scaleToFill
        label.clipsToBounds = true
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        contentView.addSubview(label)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = contentView.bounds
    }
    private func setupLayout() {
        
        label.snp.makeConstraints { make in
            make.left.equalTo(image.snp.left).offset(15)
            make.right.equalTo(image.snp.right).offset(15)
            make.top.equalTo(image.snp.top).offset(15)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.label.text = nil
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.image.image = image
            }
        }.resume()
    }
}
