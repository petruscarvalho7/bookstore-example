//
//  StringHelper.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(params: CVarArg...) -> String {
        return String(format: localized(), arguments: params)
    }
}
