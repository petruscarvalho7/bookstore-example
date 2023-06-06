//
//  BookStorSectionHeaderView.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import UIKit

class BookStoreSectionHeaderView: UICollectionReusableView {
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .white
        setupHeaderLabel()
    }
    
    private func setupHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.autoPinEdgesToSuperviewEdges(with: Constants.edgeInsets)
    }
 }
