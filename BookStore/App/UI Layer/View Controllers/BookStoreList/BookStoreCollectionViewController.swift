//
//  ViewController.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import UIKit
import Combine
import PureLayout
import MBProgressHUD
import CoreData

var booksData = [BookStoreData]()

protocol BookStoreCollectionDelegate {
    func addSavedBook(book: BookStore)
    func removeSavedBook(book: BookStore)
}

class BookStoreCollectionViewController: UIViewController {
    
    private let bookViewModel: BookStoreViewModel = BookStoreViewModel()
    private var cancelables = Set<AnyCancellable>()
    private var collectionView: UICollectionView?
    private var loadingHUD: MBProgressHUD?
    private let refreshControll: UIRefreshControl = UIRefreshControl()
    private var isBooksSelected: Bool = true
    
    private struct Constants {
        static let cellIdentifier: String = "bookCell"
        static let cellHeight: CGFloat = 100
        static let sectionHeaderIdentifier: String = "sectionHeader"
        static let sectionHeight: CGFloat = 50
        static let collectionViewInsets = UIEdgeInsets(top: 140, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBinders()
        setupLoadinHUD()
        retrieveSchoolData()
        setupRefreshControll()
        
        booksData = DataManager.shared.books()
        
        self.title = Localizable.bookStoreAppTitle
    }
    
    private func reloadDataAndRemoveStates() {
        self.loadingHUD?.hide(animated: true)
        self.removeStateView()
        self.collectionView?.reloadData()
    }
    
    private func setupBinders() {
        bookViewModel.$books
            .receive(on: RunLoop.main)
            .sink { books in
                if books.isEmpty {
                    self.showEmptyState()
                } else {
                    self.reloadDataAndRemoveStates()
                }
            }
            .store(in: &cancelables)
        
        bookViewModel.$savedBooks
            .receive(on: RunLoop.main)
            .sink { savedBooks in
                if savedBooks.isEmpty {
                    self.showEmptyState()
                    let booksCodeData = DataManager.shared.getBookStores()
                    if !booksCodeData.isEmpty {
                        self.bookViewModel.setSavedBooks(books: booksCodeData)
                        self.reloadDataAndRemoveStates()
                    }
                } else {
                    self.reloadDataAndRemoveStates()
                }
            }
            .store(in: &cancelables)
        
        bookViewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    
                    switch error {
                    case .networkingError(let errorMessage):
                        self.showErrorState(errorMessage)
                    }
                }
            }
            .store(in: &cancelables)
            
    }
    
    fileprivate func setupSegmentControl() {
        let mySegmentedControl = UISegmentedControl (items: ["Show","Filter"])
        
        let xPostion:CGFloat = 10
        let yPostion:CGFloat = 100
        let elementWidth:CGFloat = 300
        let elementHeight:CGFloat = 30
        
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        
        mySegmentedControl.selectedSegmentIndex = 0
        mySegmentedControl.tintColor = UIColor.yellow
        mySegmentedControl.backgroundColor = UIColor.lightGray
        mySegmentedControl.center.x = view.center.x
        
        // Add function to handle Value Changed events
        mySegmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        view.addSubview(mySegmentedControl)
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: Constants.cellHeight)
        collectionViewLayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: Constants.sectionHeight)
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        
        setupSegmentControl()
        
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges(with: Constants.collectionViewInsets)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true

        // setup and customize flow layout
        collectionView.register(BookStoreCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLoadinHUD() {
        guard let collectionView = collectionView else {
            return
        }
        loadingHUD = MBProgressHUD.showAdded(to: collectionView,
                                             animated: true)
        loadingHUD?.label.text = Localizable.schoolLoadingHUDTitle
        loadingHUD?.isUserInteractionEnabled = false
        loadingHUD?.detailsLabel.text = Localizable.schoolLoadingHUDSubTitle
    }
    
    private func setupRefreshControll() {
        refreshControll.attributedTitle = NSAttributedString(string: Localizable.schoolPullToRefresh)
        refreshControll.addTarget(self,
                                  action: #selector(refresh),
                                  for: .valueChanged)
        collectionView?.addSubview(refreshControll)
    }
    
    @objc private func refresh() {
        retrieveSchoolData(withPagination: true)
        refreshControll.endRefreshing()
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        isBooksSelected = sender.selectedSegmentIndex == 0
        
        if (isBooksSelected && bookViewModel.books.isEmpty) {
            self.showEmptyState()
        } else if (!isBooksSelected && bookViewModel.savedBooks.isEmpty) {
            self.showEmptyState()
        }

        self.collectionView?.reloadData()
    }
    
    private func retrieveSchoolData(withPagination: Bool = false) {
        removeStateView()
        loadingHUD?.show(animated: true)
        withPagination ? bookViewModel.getBooks() : bookViewModel.getBooks(page: "0")
    }
}

extension BookStoreCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isBooksSelected ? bookViewModel.books.count : bookViewModel.savedBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? BookStoreCollectionViewCell else { return UICollectionViewCell() }
        
        cell.populate(isBooksSelected ? bookViewModel.books[indexPath.item] : bookViewModel.savedBooks[indexPath.item])
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (isBooksSelected && indexPath.item == bookViewModel.books.count - 1) {
            refresh()
        }
    }
}

extension BookStoreCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = isBooksSelected ? bookViewModel.books[indexPath.item] : bookViewModel.savedBooks[indexPath.item]

        let bookDetailVC = BookStoreDetailCollectionViewController()
        bookDetailVC.populate(book: book, bookStoreCollectionDelegate: self, isFav: !isBooksSelected || self.bookViewModel.savedBooks.contains(where: { $0.id == book.id }))
        
        navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}

extension BookStoreCollectionViewController {
    func showErrorState(_ errorMessage: String? = "") {
        let errorStateView = BookStoreListStateView(forAutoLayout: ())
        errorStateView.update(for: .error)
        collectionView?.backgroundView = errorStateView
    }

    func showEmptyState(_ emptyMessage: String? = "") {
        let emptyStateView = BookStoreListStateView(forAutoLayout: ())
        emptyStateView.update(for: .empty)
        collectionView?.backgroundView = emptyStateView
    }
    
    func removeStateView() {
        collectionView?.backgroundView = nil
    }
}

extension BookStoreCollectionViewController: BookStoreCollectionDelegate {
    func addSavedBook(book: BookStore) {
        bookViewModel.addSavedBook(book: book)

        let bookData = DataManager.shared.book(book: book)
        booksData.append(bookData)
        DataManager.shared.save()

        self.collectionView?.reloadData()
    }
    
    func removeSavedBook(book: BookStore) {
        bookViewModel.removeSavedBook(book: book)

        if let bookData = booksData.first(where: {$0.id == book.id}) {
            DataManager.shared.deleteBook(book: bookData)
            booksData.removeAll(where: { $0.id == bookData.id })
        }

        self.collectionView?.reloadData()
    }
}
