//
//  UtillitiesHeader.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 13.03.2023.
//

import UIKit

class UtilitiesHeader: UICollectionReusableView {
    
    static var headerID = "Utilities"
    
    // MARK: - UI
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = UtilitiesHeader.headerID
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var divider: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.black
        return line
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(divider)
        addSubview(topTitle)
    }
    
    private func setupLayout() {
        divider.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1.25)
        }
        
        topTitle.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(divider.snp.bottom)
        }
    }
}
