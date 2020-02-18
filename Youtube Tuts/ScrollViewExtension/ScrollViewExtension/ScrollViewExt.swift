//
//  ScrollViewExt.swift
//  ScrollViewExt
//
//  Created by Ryan Cummins on 12/18/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class ScrollViewExt: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        keyboardDismissMode = .interactive
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
