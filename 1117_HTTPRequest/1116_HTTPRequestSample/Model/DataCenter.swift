//
//  DataCenter.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

class DataCenter {
    
    static var shared: DataCenter = DataCenter()
    var cardList: [CardData] = []
    
    private init() {
        loadCard()
    }
    
    private func loadCard() {
        // Request Cards

    }
    
    func saveCards() {
        // Post Cards
    }
    
}
