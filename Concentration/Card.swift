//
//  Card.swift
//  Concentration
//
//  Created by WY NG on 21/7/2018.
//  Copyright © 2018 lumanman. All rights reserved.
//

import Foundation

// 絕不會有一個emoji變數，因為emoji是 UI！！！！
// struct: value type
struct Card {
    // 記錄一張卡是否是面朝上的
    var isFaceUp = false   // 開始的時候是朝下的
    // 記錄是否已匹配
    var isMatched = false  // 開始的時候是沒有被匹配的
    // 以分辨出哪張卡片，方便與另一張卡片匹配
    var identifier: Int
    
    // a variable that's stored with the type, not with each individual card
    static var identifierFactory = 0
    
    // let the card figure out its own unique identifier
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // MARK: 初始化Card
//    init(identifier: Int) {
//        // use self to identify the globel variables
//         self.identifier = identifier
//    }
    
    // concentration game不需要知道identifiers 是什麼，只需知道它們是不是唯一的
    // 所以每次init時自己創造一個unique identifier
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
