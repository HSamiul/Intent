//
//  Miscellaneous.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import Foundation
import SwiftUI

class Constants {
}

class Mock {
    static var bullet1 = Bullet(text: "Get candles")
    static var bullet2 = Bullet(text: "Pick up Jenn")
    static var bullet3 = Bullet(text: "Check in with Ron")
    
    static var block1 = Block(name: "John's birthday", time: Date.now)
    static var block2 = Block(name: "Dinner with friends", time: Date.now + 1000)
    static var block3 = Block(name: "Finish final project", time: Date.now + 5000, bullets: [bullet3])
    static var block4 = Block(name: "Dinner plans", time: Date.now + 20000, bullets: [bullet1, bullet2])
}
