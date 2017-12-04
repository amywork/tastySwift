//
//  MusicDataManager.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 26..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import Foundation
class MusicDataManager
{
    var songDatas:[SongDataModel] = []
    
    init() {
        loadData()
    }
    
    
    func loadData()
    {
        for i in 0...29
        {
            if let model = SongDataModel(fileName: "\(i)")
            {
                songDatas.append(model)
            }            
        }
    }
    
}
