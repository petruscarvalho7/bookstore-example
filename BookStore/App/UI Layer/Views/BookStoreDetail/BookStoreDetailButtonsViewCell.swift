//
//  BookStoreDetailButtonsViewCell.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import UIKit

class BookStoreDetailButtonsViewCell: UICollectionViewCell {
    private struct Constants {
        static let topInset: CGFloat = 10
        static let rightInset: CGFloat = 10
        static let btnViewInsets = UIEdgeInsets(top: 10, left: 300, bottom: 10, right: 10)
    }
    
    var isChecked: Bool = false
    var bookStoreDetailDelegate: BookStoreDetailDelegate?
    var indexPath: IndexPath?
    
    var likeButton: UIButton = .btnFooter("like-unchecked")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupViews() {
        backgroundColor = .white
        setupButton()
    }
    
    private func setupButton() {
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        
        addSubview(likeButton)
        likeButton.autoPinEdgesToSuperviewEdges(with: Constants.btnViewInsets)
    }
    
    @objc func likeAction() {
        updateLikeButton(withRefresh: true)
    }
    
    func populate(isChecked: Bool = false, indexPath: IndexPath, delegate: BookStoreDetailDelegate) {
        self.isChecked = isChecked
        self.indexPath = indexPath
        self.bookStoreDetailDelegate = delegate
        
        updateLikeButton()
    }
    
    private func updateLikeButton(withRefresh: Bool = false) {
        if self.isChecked {
            likeButton.setImage(UIImage(named: "like-checked"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "like-unchecked"), for: .normal)
        }
        
        if withRefresh,
           let indexPath = self.indexPath
        {
            bookStoreDetailDelegate?.reloadButtonsCell(indexPath: indexPath)
        }
    }
 }
