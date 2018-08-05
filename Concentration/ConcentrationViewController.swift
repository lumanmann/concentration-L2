//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by WY NG on 20/7/2018.
//  Copyright © 2018 lumanman. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // MARK: Properties & Outlet
    
    // 實現Concentration，也讓這個controller可以調用model的open API
    // lazy：不會被初始化，直到有人使用它（但不能使用property observer）
     lazy var game = Concentration(numberOfPairsOfCards: (self.cardButtons.count + 1)/2)
    
    // property ＝ instance variable
    // 當你宣告一物件(Object)變數為某一資料型態的類別,這物件便可以說是此類別的一個實例(Instance),此時的資料成員可以稱為實例變數(Instance variable)
    // Swift 要求實例變數的所有屬性都要初始化
    // 翻牌次數
    var flipCount: Int = 0 {
        // observer: 監視屬性的除初始化之外的屬性值變化
        // 在屬性值改變後觸發didSet
        didSet {
            //每當flipCount的值改變 更新flipCountLabel的字
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
   
    // 卡片的emoji內容
    var emojiChoices = ["👻", "😈", "👾", "💩", "☠️", "👽", "😼", "🤖"]
    var emoji = [Int:String]()
  //  1: "👻", 2: "😈", 3: "👾", 4: "💩", 5: "☠️"
    
    // 卡片集合
    @IBOutlet var cardButtons: [UIButton]!
    // 顯示翻過了多少張牌的標籤
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    // MARK: Action
    
    // 按到卡片時會執行
    @IBAction func touchCard(_ sender: UIButton) {
        // 每次按到卡片 flipCount 都會加一
        flipCount += 1
        // 確定cardButtons的index不是空（都有連到）後轉換卡片的樣式，不然print提示
        // array.index = array裡的位置
        if let cardNumber = cardButtons.index(of: sender) {
            // 讓model來處理選中的卡片，完成卡片的配對
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("not in cardButtons")
        }
    }

    // 按遊戲的狀態（配對的狀況）更新UI
    func updateViewFromModel() {
        // 查看所有的卡片是否是面朝上和是否已經配對了，確保button的設置和卡片保持一致
        for index in cardButtons.indices {
            // 拿出與index相配的button和卡片
            let button = cardButtons[index]
            let card = game.cards[index]
            // 如果該卡片是面朝上的話，則在白色的button上顯示卡片的emoji
            // 如果該卡片是面朝下的話，則不顯示卡片的emoji，並判斷卡片是否配對了，更改卡片的背景色
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                // 讓配對了的卡片變成透明，未配對的就用橙色
                button.backgroundColor = card.isMatched ? UIColor(red: 0, green: 0, blue: 0, alpha: 0) : UIColor.orange
            }
        }
    }
    
    
    // 按卡片的identifier選用emojiChoices中的 emoji
    
    func emoji(for card: Card) -> String {
        
        // 如果emoji dictionary在這個identifier上的位置是空而我們還有emoji的話，就把一個emoji加到dictionary中
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                // 在0到array的上限之間產生一個隨機數
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                // 在array移除用過的emoji，確保不會用重複的emoji
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        
        // 返回dictionary的emoji它不是空的話，就用它的關聯值，nil的話用"？"
        
        //        if emoji[card.identifier] != nil {
        //           return emoji[card.identifier]!
        //        } else {
        //            return "?"
        //        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    // 控制卡片的顯示樣式
//    func flipCard(withEmoji emoji: String, on button: UIButton) {
//        // 判斷按鈕是否已經顯示了emoji
//        // 如果有就翻過去，不顯示字，背景色設為橙色
//        if button.currentTitle == emoji {
//            button.setTitle("", for:  .normal)
//            button.backgroundColor = UIColor.orange
//        } else {
//            //如果沒有emoji的話，那就把emoji顯示在白色背景上
//            button.setTitle("\(emoji)", for: .normal)
//            button.backgroundColor = UIColor.white
//        }
//    }
}



