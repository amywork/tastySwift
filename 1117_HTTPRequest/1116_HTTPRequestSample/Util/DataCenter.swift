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
    var cardList: [CardData]?
    var token: String = ""
    
    private init() {
        self.loadCard()
        print(self.token)
        print(cardList)
    }
    
    private func loadCard() {
        NetworkManger.shared.requestGetPosts { (isSucess, data, err) in
            if isSucess {
                self.cardList = data as? [CardData]
            }
        }
    }
    
    func saveCards() {
        // Post Cards
    }
    
}
