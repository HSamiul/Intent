//
//  Miscellaneous.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import Foundation
import SwiftUI

extension String {
    var isBlank: Bool {
        for char in self {
            print("char: \(char)")
            if !char.isWhitespace {
                return false
            }
        }
        return true
    }
}

class Constants {
}

class Mock {
    static var bullet1 = Bullet("Get candles")
    static var bullet2 = Bullet("Pick up Jenn")
    static var bullet3 = Bullet("Check in with Ron")
    
    static var block1 = Block(name: "John's birthday", date: Date.now)
    static var block2 = Block(name: "Dinner with friends", date: Date.now + 1000)
    static var block3 = Block(name: "Finish final project", date: Date.now + 5000, bullets: [bullet3])
    static var block4 = Block(name: "Dinner plans", date: Date.now + 20000, bullets: [bullet1, bullet2])
}
