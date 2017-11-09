//
//  DataCenter.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
let key = "cardListKey"

class DataCenter {
    
    static var main: DataCenter = DataCenter()
    var cardList: [CardData] = []
    
    var selectedCard: CardData? {
        didSet {
            // For Widget - 앱과 위젯 사이 정보를 주고받기 위함
            let groupUser = UserDefaults(suiteName: "group.wingjoo.developer.todayextension")
            if let _ = selectedCard {
                groupUser?.set(selectedCard?.cardDic, forKey: "selectedCardKey")
            }else {
                groupUser?.set(nil, forKey: "selectedCardKey")
            }
            
        }
    }
    
    private init() {
        loadCardData()
    }
    
    private func loadCardData() {
        guard let list = UserDefaults.standard.value(forKey: key) as? [[String:Any]] else { return }
        
        for dic in list
        {
            if let newCard = CardData(dataDic: dic)
            {
                cardList.append(newCard)
            }
        }
    }
    
    func saveCards() {
        var cardDicList:[Any] = []
        for card in cardList
        {
            cardDicList.append(card.cardDic)
        }
        UserDefaults.standard.set(cardDicList, forKey: key)
    }
    
    
    func addCard(name:String, data:Data) {
        cardList.append(CardData(name: name, data: data))
        saveCards()
    }
    
    
}
