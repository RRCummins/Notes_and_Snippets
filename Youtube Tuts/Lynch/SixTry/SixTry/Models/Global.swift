//
//  Global.swift
//  SixTry
//
//  Created by Ryan Cummins on 3/9/22.
//

import UIKit

enum Global {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.size.height
    }
    
    static var minDimension: CGFloat {
        min(screenWidth, screenHeight)
    }
    
    static var boardWidth: CGFloat {
        switch minDimension {
        case 0...320:
            // iPod Toouch
            return screenWidth - 55
        case 321...430:
            // iPhone
            return screenWidth - 50
        case 431...1000:
            //iPad
            return 350
        default:
            // largest iPad or Mac
            return 500
        }
    }
    
    static var keyboardScale: CGFloat {
        switch minDimension {
        case 0...430:
            return screenWidth / 390
        case 431...1000:
            return CGFloat(1.2)
        default:
            return CGFloat(1.6)
        }
    }
}
