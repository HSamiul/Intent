//
//  DayView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

class Day: ObservableObject {
    @Published var blocks: [Block]
    @Published var newBlockSheetVisible: Bool
    
    init(blocks: [Block]) {
        self.blocks = blocks
        self.newBlockSheetVisible = false
    }
}

struct DayView: View {
    @ObservedObject private var day: Day
    
    init(day: Day) {
        self.day = day
    }
    
    var body: some View {
        VStack {
            ForEach(self.day.blocks) { block in
                BlockView(block: block)
            }
            
            CircleButton(systemName: "plus") {
                self.day.newBlockSheetVisible = true
            }
            .padding()
        }
        .sheet(isPresented: $day.newBlockSheetVisible) {
            NewBlockSheet(day: day)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var blocks = [Mock.block1, Mock.block2, Mock.block3]
    static var day = Day(blocks: blocks)
    
    static var previews: some View {
        DayView(day: day)
            .padding()
    }
}
