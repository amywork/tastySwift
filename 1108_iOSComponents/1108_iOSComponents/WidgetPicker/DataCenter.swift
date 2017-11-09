//
//  DataCenter.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
class DataCenter {
    
    static var main: DataCenter = DataCenter()
    var cards: [CardData] = []
    
    private init() {
    }
    
    func addCard(card: CardData) {
        self.cards.append(card)
    }

    
}
