//
//  BookStoreTests.swift
//  BookStoreTests
//
//  Created by Petrus Carvalho on 05/06/23.
//

import XCTest
import Combine
@testable import BookStore_debug

final class BookStoreTests: XCTestCase {
    
    private var cancelables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func setUp() async throws {
        try await super.setUp()
        cancelables.removeAll()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGettingBookStoreWithEmptyReturn() throws {
        let expectation = expectation(description: "should testing mockapi with empty values returned.")
        
        let apiMock = MockBookStoreAPI()
        apiMock.loadState = .empty
        
        let bookViewModel = BookStoreViewModel(apiService: apiMock)
        bookViewModel.getBooks()
        
        bookViewModel.$books
            .receive(on: RunLoop.main)
            .sink { books in
                let books = books
                if !books.isEmpty {
                    XCTFail("it does receive values")
                    return
                }
                XCTAssertTrue(books.isEmpty == true, "expected books must be empty")
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed! \(error)")
            }
        }
    }
    
    func testGettingBookStoreWithLoadedReturn() throws {
        let expectation = expectation(description: "should testing mockapi with values returned.")
        
        let apiMock = MockBookStoreAPI()
        apiMock.loadState = .loaded
        
        let bookViewModel = BookStoreViewModel(apiService: apiMock)
        bookViewModel.getBooks()
        
        bookViewModel.$books
            .receive(on: RunLoop.main)
            .sink { books in
                let books = books
                if books.isEmpty {
                    XCTFail("it doesn't receive any values")
                }
                XCTAssertTrue(books.isEmpty == false, "expected books must be with values returned.")
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed! \(error)")
            }
        }
    }
    
    func testGettingBookStoreWithErrorReturn() throws {
        let expectation = expectation(description: "should testing mockapi with an error returned.")
        
        let apiMock = MockBookStoreAPI()
        apiMock.loadState = .error
        
        let bookViewModel = BookStoreViewModel(apiService: apiMock)
        bookViewModel.getBooks()
        
        bookViewModel.$error
            .receive(on: RunLoop.main)
            .sink { error in
                let error = error
                if error == nil {
                    XCTFail("it should have returned an error")
                    return
                }
                XCTAssertNotNil(error, "expected getbooks must shown an error")
                expectation.fulfill()
                
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed! \(error)")
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
