//
//  UIBarButtonItemColor.swift
//  colorCheckGame
//
//  Created by Tony Marko on 05/03/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class UIBarButtonItemColor: UIBarButtonItem {
    
    var color: UIColor!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        switch self.tag {
        case 1:
            self.color = UIColor(colorLiteralRed: 0.988, green: 0.98, blue: 0.964, alpha: 1.0)
        case 2:
            self.color = UIColor(colorLiteralRed: 0.2196, green: 0.2156, blue: 0.2078, alpha: 1.0)
        default:
            self.color = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    var isActive = false {
        didSet {
            if self.isActive {
                self.tintColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            } else {
                self.tintColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            }
        }
    }
    
}
