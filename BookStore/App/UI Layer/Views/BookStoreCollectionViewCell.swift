//
//  BookStoreCollectionViewCell.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation
import UIKit

class BookStoreCollectionViewCell: UICollectionViewCell {
    private var book: BookStore?
    
    private struct Constants {
        static let leftInset: CGFloat = 10
        static let topInset: CGFloat = 10
        static let rightInset: CGFloat = 10
        static let bottomInset: CGFloat = 30
        static let borderWidth: CGFloat = 0.5
        static let imageHeight: CGFloat = 80
        static let cornerRadius: CGFloat = 10.0
        static let wrapperViewInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        static let imageViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 250)
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var bookImageView: UIImageView = {
        var bookImg = UIImageView(image: UIImage(named: "bookplaceholder"))
        bookImg.frame.size = CGSize(width: 40.0, height: Constants.imageHeight)
        return bookImg
    }()
    
    private var wrapperView: UIView = {
        let view = UIView(forAutoLayout: ())
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
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
        setupWrapperView()
        setupTitleLabel()
        setupAuthorLabel()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges(with: Constants.wrapperViewInsets)
        
        wrapperView.addSubview(bookImageView)
        bookImageView.autoPinEdgesToSuperviewEdges(with: Constants.imageViewInsets)
        bookImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.leftInset)
        bookImageView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.rightInset)
    }
    
    private func setupTitleLabel() {
        wrapperView.addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: Constants.topInset)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.rightInset)
        titleLabel.autoPinEdge(.leading, to: .trailing, of: bookImageView, withOffset: Constants.topInset)
        titleLabel.addShadow()
    }
    
    private func setupAuthorLabel() {
        wrapperView.addSubview(authorLabel)
        authorLabel.autoPinEdge(.leading, to: .trailing, of: bookImageView, withOffset: Constants.topInset)
        authorLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.rightInset)
        authorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: Constants.topInset)
        authorLabel.addShadow()
    }
    
    func populate(_ book: BookStore) {
        self.book = book
        titleLabel.text = book.volumeInfo.title
        authorLabel.text = book.volumeInfo.authors.joined(separator: ", ")
        
        if let urlImage = book.volumeInfo.imageLinks?.thumbnail {
            bookImageView.getImageFromURLString(imageURLString: urlImage)
        }
    }
 }
