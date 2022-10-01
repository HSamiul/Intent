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
    
    init(name: String = "", date: Date = Date(), bullets: [Bullet] = []) {
        self.name = name
        self.bullets = bullets
        self.date = date
        self.editBlockSheetVisible = false
    }
    
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
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
    static var block = Block(name: "Birthday Party", date: Date.now, bullets: bullets)
    
    static var previews: some View {
        BlockView(block: block)
            .padding()
    }
}

