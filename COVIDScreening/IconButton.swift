//
//  IconButton.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 3/19/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import UIKit

@IBDesignable
class IconButton: UIButton {
    @IBInspectable var pointSize:CGFloat = 150.0

    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: pointSize)
            setPreferredSymbolConfiguration(config, forImageIn: .normal)
        } else {
            // Fallback on earlier versions
        }
    }
}
