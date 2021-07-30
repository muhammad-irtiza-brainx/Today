//
//  UITableViewCell.swift
//  Today
//
//  Created by BrainX Technologies 11 on 29/07/2021.
//

import UIKit

extension UITableViewCell {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }
}
