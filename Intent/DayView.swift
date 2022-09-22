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
        ScrollView {
            VStack {
                ForEach(self.day.blocks.sorted { block1, block2 in block1.time < block2.time}) { block in
                    BlockView(block: block)
                }
                .padding(.horizontal)
                
                CircleButton(systemName: "plus") {
                    self.day.newBlockSheetVisible = true
                }
                .padding()
              
                if self.day.blocks.isEmpty {
                    Text("No blocks set for today.")
                        .foregroundColor(.gray)
                }
            }
        }
        .environmentObject(self.day) // supply day to blocks
        .sheet(isPresented: $day.newBlockSheetVisible) {
            NewBlockSheet(day: day)
        }
    }
}

struct DayView_Previews: PreviewProvider {
//    static var blocks = [Mock.block2, Mock.block4, Mock.block1, Mock.block3]
    static var blocks = [Block]()
    static var day = Day(blocks: blocks, date: Date.now)
    
    static var previews: some View {
        DayView(day: day)
    }
}
