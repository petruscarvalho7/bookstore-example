//
//  ImageViewHelper.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import UIKit
import Foundation

extension UIImageView {

    public func getImageFromURLString(imageURLString: String) {
        // imageURLString.replacingOccurrences: workaround to fix http prefix
        guard let imageURL = URL(string: imageURLString.replacingOccurrences(of: "http", with: "https")) else { return}
        Task {
            await requestImageFromURL(imageURL)
        }
    }

    private func requestImageFromURL(_ imageURL: URL) async{
        let urlRequest = URLRequest(url: imageURL)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    print("image download complete.")
                }
            }
            // Loading the image here
            self.image = UIImage(data: data)
        } catch let error {
            print(error)
        }
    }
}
