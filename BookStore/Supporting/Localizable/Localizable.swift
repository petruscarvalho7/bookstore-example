//
//  Localizable.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//
import Foundation

enum Localizable {
    
    // App name
    static var bookStoreAppTitle: String { "bookStore.title.app".localized() }
    
    // BookStore Details
    static var bookStoreDetailsTitle: String { "bookStore.title".localized() }
    static var bookStoreDetailsAuthor: String { "bookStore.author".localized() }
    static var bookStoreDetailsDescription: String { "bookStore.description".localized() }
    static var bookStoreDetailsAvailable: String { "bookStore.available".localized() }
    static var bookStoreDetailsBuyLink: String { "bookStore.buyLink".localized() }
    static var bookStoreDetailsAvailableText: String { "bookStore.available.text".localized() }
    static var bookStoreDetailsSoldOutText: String { "bookStore.soldOut.text".localized() }
    
    // Errors
    static var bookStoreErrorsLoadingTitle: String { "bookStore.errors.loading.title".localized() }
    static var bookStoreErrorsLoadingDesc: String { "bookStore.errors.loading.desc".localized() }
    static var bookStoreListEmptyTitle: String { "bookStore.list.empty.title".localized() }
    static var bookStoreListEmptyDesc: String { "bookStore.list.empty.desc".localized() }
    
    // Pull to refresh
    static var schoolPullToRefresh: String { "pull-to-refresh".localized() }
    
    // HUD
    static var schoolLoadingHUDTitle: String { "loading.hud.title".localized() }
    static var schoolLoadingHUDSubTitle: String { "loading.hud.subtitle".localized() }
}
