//
//  BookStoreDetailCollectionViewController.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import UIKit
import PureLayout

protocol BookStoreDetailDelegate {
    func reloadButtonsCell(indexPath: IndexPath)
}

class BookStoreDetailCollectionViewController: UIViewController {
    
    private let bookStoreDetailViewModel: BookStoreDetailViewModel = BookStoreDetailViewModel()
    private var bookStoreCollectionDelegate: BookStoreCollectionViewController?
    private var collectionView: UICollectionView?
    
    struct Constants {
        static let cellIdentifier: String = "bookDetailCell"
        static let cellButtonIdentifier: String = "bookDetailButtonCell"
        static let cellHeight: CGFloat = 240
        static let cellButtomHeight: CGFloat = 64
        static let sectionHeaderIdentifier: String = "sectionHeader"
        static let sectionHeight: CGFloat = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func populate(book: BookStore, bookStoreCollectionDelegate: BookStoreCollectionViewController, isFav: Bool) {
        bookStoreDetailViewModel.populate(book: book, isFavorite: isFav)
        
        self.bookStoreCollectionDelegate = bookStoreCollectionDelegate
        self.title = book.volumeInfo.title
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: Constants.cellHeight)
        collectionViewLayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: Constants.sectionHeight)
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        // setup and customize flow layout
        collectionView.register(BookStoreDetailViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.register(BookStoreDetailButtonsViewCell.self, forCellWithReuseIdentifier: Constants.cellButtonIdentifier)
        collectionView.register(BookStoreSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.sectionHeaderIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
    
}

extension BookStoreDetailCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? BookStoreDetailViewCell else { return UICollectionViewCell() }
            
            
            if let book = bookStoreDetailViewModel.book {
                cell.populate(book)
            }
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellButtonIdentifier, for: indexPath) as? BookStoreDetailButtonsViewCell else { return UICollectionViewCell() }
            
            cell.populate(isChecked: bookStoreDetailViewModel.isFavorite, indexPath: indexPath, delegate: self)
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return bookStoreDetailViewModel.sectionList?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
           let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.sectionHeaderIdentifier, for: indexPath) as? BookStoreSectionHeaderView {
            sectionHeader.headerLabel.text = indexPath.section == 0 ? Localizable.bookStoreDetailsTitle : ""
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension BookStoreDetailCollectionViewController: UICollectionViewDelegate {
    
}

extension BookStoreDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 0) {
            return CGSize(width: collectionView.bounds.width, height: Constants.cellHeight)
        }
        return CGSize(width: collectionView.bounds.width, height: Constants.cellButtomHeight)
    }
}

extension BookStoreDetailCollectionViewController: BookStoreDetailDelegate {
    func reloadButtonsCell(indexPath: IndexPath) {
        if let book = self.bookStoreDetailViewModel.book {
            if self.bookStoreDetailViewModel.isFavorite {
                self.bookStoreCollectionDelegate?.removeSavedBook(book: book)
            }
            else {
                self.bookStoreCollectionDelegate?.addSavedBook(book: book)
            }
        }

        self.bookStoreDetailViewModel.handleFavoriteBtn()
        self.collectionView?.reloadItems(at: [indexPath])
    }
}
