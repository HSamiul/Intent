//
//  BulletView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/21/22.
//

import SwiftUI

class Bullet: ObservableObject {
    @Published var text: String
    
    init(text: String) {
        self.text = text
    }
}

struct BulletView: View {
    @ObservedObject private var bullet: Bullet
    
    init(bullet: Bullet) {
        self.bullet = bullet
    }
    
    var body: some View {
        HStack {
            Text("•")
                .foregroundColor(.accentColor)
            Text(bullet.text)
        }
    }
}

struct BulletView_Previews: PreviewProvider {
    static var bullet = Bullet(text: "A really important detail")
    static var previews: some View {
        BulletView(bullet: bullet)
    }
}
