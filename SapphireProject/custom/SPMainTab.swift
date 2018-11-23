//
//  SPMainTab.swift
//  SapphireProject
//
//  Created by admin on 11/23/18.
//  Copyright © 2018 telkom. All rights reserved.
//

import UIKit

class SPMainTab : UITabBar {
    @IBInspectable var height: CGFloat = 0.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}
