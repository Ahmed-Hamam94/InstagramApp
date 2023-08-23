//
//  UIColor+extension.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import Foundation
import UIKit

extension UIColor {
    
    static func appColor(_ name: Constants.AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    
}
