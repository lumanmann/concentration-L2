//
//  Concentration.swift
//  Concentration
//
//  Created by WY NG on 21/7/2018.
//  Copyright © 2018 lumanman. All rights reserved.
//

import Foundation

class Concentration {
    // 存放卡片的Array
    var cards = [Card]()
    
    // 不是只有一張朝上的卡＝nil；只有一張朝上的卡＝卡片的index
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    // MARK: Action
    
    // 當用戶選擇了一張卡要做的動作-翻牌及配對
    func chooseCard(at index: Int){
//         用subscript訪問Array元素
//        // 如果在那個index的卡牌是面朝上的，就讓那卡片的 isFaceUp 屬性為 false，否則就設為 true
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
        
        // 如果選中的卡已經配對了的另一張卡的話，就直接忽略它，什麼也不做
        if !cards[index].isMatched {
            // 如果已有一張朝上的卡，面且所選中的卡片跟它不一樣，我們就可以進行配對的動作
            if let mactchIndex = indexOfOneAndOnlyFaceUpCard, mactchIndex != index {
                // check if cards match
                // 透過mactchIndex和卡片的identifier檢查是否卡片是可配對的
                // 如果identifier都一樣就完成配對，改變相關isMatched 屬性
                if cards[mactchIndex].identifier == cards[index].identifier {
                    cards[mactchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // 如果identifier都不一樣就配對失敗，改變相關屬性
                cards[index].isFaceUp = true
                // 有兩張朝上的卡，所以indexOfOneAndOnlyFaceUpCard改為nil
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // eithrer no card or 2 cards are face up
                // 沒有卡片朝上或者有兩張卡片朝就把所有的卡翻到背面
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                // 如果沒有卡片面朝上的時候選了一張卡，那就把它翻過來
                cards[index].isFaceUp = true
                // 只有一張卡片朝上，所以indexOfOneAndOnlyFaceUpCard改為它的index
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // MARK: 初始化
    init(numberOfPairsOfCards: Int) {
//        for identifier in 1...numberOfPairsOfCards {
//            // 創建一張卡片
//            let card ＝ Card(identifier: identifier)
//            // 創建另一張有著相同identifier的卡片，讓我們有兩張能夠匹配的卡片
//            let matchingCard = card
//            // 把二張卡片加到 array 中
//            cards.append(card)
//            cards.append(matchingCard)
//        }
        
        // 簡化
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // 把東西放到 array 或者從裡面拿出來也是複製
            cards += [card, card]
        }
        
        // TODO: shuffle the cards
        cards = cards.shuffled()
        
    }
}


extension MutableCollection {
    // 打亂collection的次序
    mutating func shuffle() {
        // 拿到該collection的count屬性
        let c = count
        // 確保collection有多於一個element
        guard c > 1 else { return }
        // zip：將兩個collection的元素，一一對應合併生成一個新序列。
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // 用arc4random_uniform生成一個亂數
            let d = Int(arc4random_uniform(UInt32(unshuffledCount)))
            // 返回與index的指定距離(亂數d)外的index
            let i = index(firstUnshuffled, offsetBy: d)
            // 用指定的indices--本來的indice和隨機的i，交換collection的values
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Array {
    // 返回已打亂的一個array
    func shuffled() -> [Element] {
        var result = self
        result.shuffle()
        return result
    }
}
