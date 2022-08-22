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
    let date: Date
    
    init(blocks: [Block], date: Date = Date.now) {
        self.blocks = blocks
        self.newBlockSheetVisible = false
        self.date = date
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
    static var blocks = [Mock.block1, Mock.block2, Mock.block3, Mock.block4]
    static var day = Day(blocks: blocks, date: Date.now)
    
    static var previews: some View {
        DayView(day: day)
            .padding()
    }
}
