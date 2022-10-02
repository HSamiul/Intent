//
//  Block.swift
//  Intent
//
//  Created by Samiul Hoque on 8/10/22.
//

import SwiftUI

class Block: ObservableObject, Identifiable {
    @Published var name: String
    @Published var date: Date
    @Published var bullets: [Bullet]
    @Published var editBlockSheetVisible: Bool
    
    let id = UUID()
    
    init(_ name: String = "", date: Date = Date(), bullets: [Bullet] = []) {
        self.name = name
        self.bullets = bullets
        self.date = date
        self.editBlockSheetVisible = false
        
        polish()
    }
    
    /* return this block's time as a human-readable string */
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
    /* modify this block's bullets to remove any that don't have text */
    func cleanUpBullets() {
        bullets = bullets.filter({ bullet in
            return !bullet.text.isBlank
        })
        
        for bullet in bullets {
            bullet.text = bullet.text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    func cleanupName() {
        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func polish() {
        cleanUpBullets()
        cleanupName()
    }
    
    func update(name: String, date: Date, bullets: [Bullet]) {
        self.name = name
        self.date = date
        self.bullets = bullets
        
        polish()
    }
}

struct BlockView: View {
    @EnvironmentObject var day: Day
    @ObservedObject private var block: Block
    
    init(block: Block) {
        self.block = block
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(block.formattedTime())
                    .foregroundColor(.gray)
                    .font(.system(.caption)).bold()
                Text(block.name)
                    .font(.system(.headline))
                    .padding(.top, 1)
                
                if (!block.bullets.isEmpty) {
                    Divider()
                    VStack(alignment: .leading) {
                        ForEach(block.bullets) { bullet in
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
            EditBlockSheet(day: self.day, block: self.block)
        }
    }
}

struct BlockView_Previews: PreviewProvider {
    static var bullets = [Mock.bullet1, Mock.bullet2, Mock.bullet3]
    static var block = Block("Birthday Party", date: Date.now, bullets: bullets)
    
    static var previews: some View {
        BlockView(block: block)
            .padding()
    }
}

