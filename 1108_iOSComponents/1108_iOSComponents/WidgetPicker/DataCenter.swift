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
    
    var likedData: CardData? {
        didSet {
            // For Widget - 앱과 위젯 사이 정보를 주고받기 위함
            let groupUser = UserDefaults(suiteName: "group.wingjoo.developer.todayextension")
            if let _ = likedData {
                updateCardData(new: likedData!)
                groupUser?.set(likedData?.dictionaryData, forKey: "likedDataKey")
            }else {
                groupUser?.set(nil, forKey: "likedDataKey")
            }
            
        }
    }
    
    private init()
    {
        loadCardData()
    }
    
    private func loadCardData()
    {
        guard let list = UserDefaults.standard.value(forKey: key) as? [[String:Any]] else { return }
        
        for dic in list
        {
            if let newCard = CardData(dataDic: dic)
            {
                cardList.append(newCard)
            }
        }
    }
    
    func saveCardsData()
    {
        var dicList:[Any] = []
        for card in cardList
        {
            dicList.append(card.dictionaryData)
        }
        UserDefaults.standard.set(dicList, forKey: key)
    }
    
    
    func addCard(name:String, data:Data)
    {
        cardList.append(CardData(name: name, data: data))
        saveCardsData() //매번 저장할 필요는 없음
    }
    
    func updateCardData(new newData:CardData)
    {
        cardList = cardList.map { (data) -> CardData in
            
            if data.cardName == newData.cardName
            {
                return newData
            }else
            {
                return data
            }
        }
        saveCardsData()
    }
    
    func addCard(card: CardData) {
        self.cardList.append(card)
    }

    
}
