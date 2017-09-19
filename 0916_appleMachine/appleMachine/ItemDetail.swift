//
//  itemClass.swift
//  appleMachine
//
//  Created by 김기윤 on 18/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation

class ItemDetail {
    
    var title: String
    var price: Int
    var stock: Int
    var isInStock: Bool = false
    
    init(title: String, price: Int, stock: Int) {
        self.title = title
        self.price = price
        self.stock = stock
    }
    
    func setStock(stock: Int) -> Bool {
        
        if stock > 0 {
            isInStock = true
        }else {
            isInStock = false
        }
        return isInStock
    }

 }
    
