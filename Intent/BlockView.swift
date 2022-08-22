//
//  Block.swift
//  Intent
//
//  Created by Samiul Hoque on 8/10/22.
//

import SwiftUI

// TODO: Require that name is not an empty string

class Block: ObservableObject, Identifiable {
    @Published var name: String
    @Published var time: Date
    @Published var bullets: [Bullet]
    @Published var editBlockSheetVisible: Bool
    
    let id = UUID()
    
    init(name: String = "", time: Date = Date.now, bullets: [Bullet] = []) {
        self.name = name
        self.time = time
        self.bullets = bullets
        self.editBlockSheetVisible = false
    }
}

struct BlockView: View {
    @ObservedObject private var block: Block
    
    init(block: Block) {
        self.block = block
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(block.time.formatted())
                    .foregroundColor(.gray)
                    .font(.system(.caption)).bold()
                Text(block.name)
                    .font(.system(.headline))
                
                if (!block.bullets.isEmpty) {
                    Divider()
                    VStack(alignment: .leading) {
                        ForEach($block.bullets) { $bullet in
                            BulletView(bullet: bullet)
                                
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CircleButton(systemName: "pencil") {
                self.block.editBlockSheetVisible = true
            }
            .padding()
        }
        .background(.regularMaterial)
        .cornerRadius(10)
//        .shadow(radius: 5)
        .sheet(isPresented: self.$block.editBlockSheetVisible) {
            EditBlockSheet(oldBlock: self.block)
        }
    }
}

struct BlockView_Previews: PreviewProvider {
    static var bullets = [Mock.bullet1, Mock.bullet2, Mock.bullet3]
    static var block = Block(name: "Birthday Party", time: Date.now, bullets: bullets)
    
    static var previews: some View {
        BlockView(block: block)
            .padding()
    }
}

