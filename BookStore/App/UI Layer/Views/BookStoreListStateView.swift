//
//  BookStoreListStateView.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation
import UIKit
import PureLayout

class BookStoreListStateView: UIView {
    private struct Constants {
        static let stackViewSpacing: CGFloat = 0.5
        static let stackViewInsets: UIEdgeInsets = UIEdgeInsets(top: 200, left: 100, bottom: 200, right: 100)
        static let headerLabelWidth: CGFloat = 200
        static let iconImageSize: CGSize = CGSize(width: 200, height: 200)
        static let headerLabelFontSize: CGFloat = 25
        static let messageLabelFontSize: CGFloat = 18
    }
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.headerLabelFontSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.messageLabelFontSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(forAutoLayout: ())
        stackView.spacing = Constants.stackViewSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges(with: Constants.stackViewInsets)

        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(messageLabel)
        
        headerLabel.autoSetDimension(.width, toSize: Constants.headerLabelWidth)
        messageLabel.autoSetDimension(.width, toSize: Constants.headerLabelWidth)
        
        stackView.addArrangedSubview(iconImageView)
        iconImageView.autoSetDimensions(to: Constants.iconImageSize)
    }
    
    func update(for state: BookStoreListState) {
        switch state {
        case .error:
            headerLabel.text = Localizable.bookStoreErrorsLoadingTitle
            messageLabel.text = Localizable.bookStoreErrorsLoadingDesc
            iconImageView.image = UIImage(named: "error")
        case .empty:
            headerLabel.text = Localizable.bookStoreListEmptyTitle
            messageLabel.text = Localizable.bookStoreListEmptyDesc
            iconImageView.image = UIImage(named: "customer")
        case .loaded:
            // this view will not used when is on this state
            break
        }
    }
}

