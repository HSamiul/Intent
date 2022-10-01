//
//  BulletView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/21/22.
//

import SwiftUI

class Bullet: ObservableObject, Identifiable, Comparable {
    @Published var text: String
    let timestamp = Date()
    let id = UUID()
    
    init(_ text: String) {
        self.text = text
    }
    
    static func == (lhs: Bullet, rhs: Bullet) -> Bool {
        lhs.timestamp == rhs.timestamp
    }
    
    static func < (lhs: Bullet, rhs: Bullet) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}

struct BulletView: View {
    @ObservedObject private var bullet: Bullet
    
    init(bullet: Bullet) {
        self.bullet = bullet
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text("•")
                .foregroundColor(.accentColor)
            Text(bullet.text)
        }
    }
}

struct BulletView_Previews: PreviewProvider {
    static var bullet = Bullet("A really important detail containing critical information in this bullet point")
    static var previews: some View {
        BulletView(bullet: bullet)
    }
}
