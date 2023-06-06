//
//  UIButtonHelper.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import UIKit

extension UIButton {
    
    static func btnFooter(_ name: String? = nil) -> UIButton {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 64)

        if let name = name {
            btn.setImage(UIImage(named: name), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
                                                                  
        }
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 32
        btn.clipsToBounds = true
        
        //shadow
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 3.0
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowOffset = CGSize(width: 1, height: 1)
        btn.layer.masksToBounds = false
        
        return btn
    }
}
