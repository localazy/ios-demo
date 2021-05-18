//
//  UILabelLocalized.swift
//  LocalazyClient UIKit
//
//  Created by Jaroslav Pulik on 18/05/2021.
//

import UIKit

class UILabelLocalized: UILabel {
    
    @IBInspectable
    var key: String? {
        didSet {
            guard let key = key else { return }
            // Use String extension to get translated string
            text = key.localazyLocalized
            // or use system call directly when using swizzling
//            text = NSLocalizedString(key, comment: key)
        }
    }
    
}
