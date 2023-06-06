//
//  BuildConfiguration.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

class BuildConfiguration {
    static let shared = BuildConfiguration()
    
    var environment: Environment
    
    var baseURL: String {
        switch environment {
        case .debug:
            return "https://www.googleapis.com/books/v1/"
        case .release:
            return "https://www.googleapis.com/books/v1/"
        }
    }
    
    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
        
        environment = Environment(rawValue: currentConfiguration)!
    }
}
