//
//  Miscellaneous.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import Foundation
import SwiftUI

class Constants {
    static var fontDesign: Font.Design = .rounded
}

class Mock {
    static var block1 = Block(name: "John's birthday", time: Date.now)
    static var block2 = Block(name: "Dinner with friends", time: Date.now + 5)
    static var block3 = Block(name: "Finish final project", time: Date.now + 10)
}
