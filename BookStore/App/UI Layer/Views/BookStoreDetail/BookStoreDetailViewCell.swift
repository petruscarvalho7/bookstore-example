//
//  BookStoreDetailViewCell.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import UIKit

class BookStoreDetailViewCell: UICollectionViewCell {
    private var book: BookStore?
    
    private struct Constants {
        static let leftInset: CGFloat = 10
        static let topInset: CGFloat = 10
        static let rightInset: CGFloat = 10
        static let bottomInset: CGFloat = 10
        static let borderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 10.0
        static let wrapperViewInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        static let spacing: CGFloat = 5.0
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private var authorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = Localizable.bookStoreDetailsAuthor
        return label
    }()
    
    private var authorsValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        return label
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = Localizable.bookStoreDetailsDescription
        return label
    }()
    
    private var descValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private var availableLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = Localizable.bookStoreDetailsAvailable
        return label
    }()
    
    private var availableValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        return label
    }()
    
    private var buyLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = Localizable.bookStoreDetailsBuyLink
        return label
    }()
    
    private var buyLinkValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        label.numberOfLines = 4
        label.textColor = .blue
        return label
    }()
    
    private var wrapperView: UIView = {
        let view = UIView(forAutoLayout: ())
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(forAutoLayout: ())
        stackView.spacing = Constants.spacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
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
        setupFields()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges(with: Constants.wrapperViewInsets)
    }
    
    private func setupFields() {
        // stackView
        wrapperView.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.leftInset)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.rightInset)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: Constants.topInset)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: Constants.bottomInset)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(authorsLabel)
        stackView.addArrangedSubview(authorsValueLabel)
        
        stackView.addArrangedSubview(descLabel)
        stackView.addArrangedSubview(descValueLabel)
        
        stackView.addArrangedSubview(availableLabel)
        stackView.addArrangedSubview(availableValueLabel)
        
        stackView.addArrangedSubview(buyLinkLabel)
        stackView.addArrangedSubview(buyLinkValueLabel)
        
    }
    
    func populate(_ book: BookStore?) {
        self.book = book
        
        if let title = book?.volumeInfo.title {
            titleLabel.text = title
        }
        
        if let authors = book?.volumeInfo.authors.joined(separator: ", ") {
            authorsValueLabel.text = authors
        }
        if let desc = book?.volumeInfo.description {
            descValueLabel.text = desc
        }
        if let available = book?.saleInfo.saleability {
            let forSale: Bool = available == .forSale
            availableValueLabel.text = forSale ?
                Localizable.bookStoreDetailsAvailableText :
                Localizable.bookStoreDetailsSoldOutText
            availableValueLabel.textColor = forSale ? .green : .red
        }
        if let buyLink = book?.saleInfo.buyLink {
            buyLinkValueLabel.text = buyLink
            buyLinkValueLabel.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleLink))
            buyLinkValueLabel.addGestureRecognizer(tap)
        } else {
            buyLinkLabel.text = ""
        }
    }
    
    @objc private func handleLink() {
        if let buyLink = book?.saleInfo.buyLink,
           let openLink = URL(string: buyLink) {
            if UIApplication.shared.canOpenURL(openLink) {
                UIApplication.shared.open(openLink, options: [:])
            }
        }
    }
 }
