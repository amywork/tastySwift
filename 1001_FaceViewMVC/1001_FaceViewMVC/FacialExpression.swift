//
//  FacialExpression.swift
//  1001_UITestStanford
//
//  Created by Kimkeeyun on 01/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation

struct FacialExpression {
    let eyes: Eyes
    let mouth: Mouth
    
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }
    
    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
        
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }

    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }    
}
