//
//  DayView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

class Day: ObservableObject {
    @Published var blocks: Dictionary<UUID, Block>
    @Published var newBlockSheetVisible: Bool
    let date: Date
    
    init(blocks: Dictionary<UUID, Block> = [:], date: Date) {
        self.blocks = blocks
        self.newBlockSheetVisible = false
        self.date = date
    }
    
    /* Attempts to add a block to day */
    func addBlock(name: String, date: Date, bullets: [Bullet] = []) -> Bool {
        if (Calendar.current.compare(self.date, to: date, toGranularity: .day) != .orderedSame) {
            return false
        } else {
            let block = Block(name, date: date, bullets: bullets)
            self.blocks.updateValue(block, forKey: block.id)
            
            return true
        }
    }
    
    func sortedBlocks() -> [Block] {
        let pairs = self.blocks.sorted { pair1, pair2 in
            pair1.value.date < pair2.value.date
        }
        
        let blocks: [Block] = pairs.map { pair in
            return pair.value
        }
        
        return blocks
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
                ForEach(self.day.sortedBlocks()) { block in
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
        //        .navigationTitle(self.day.date.formatted(.dateTime.weekday(.wide)))
        .navigationTitle(self.day.date.formatted(.dateTime.month().day().year()))
        .sheet(isPresented: $day.newBlockSheetVisible) {
            NewBlockSheet(day: day)
        }
    }
}
    
struct DayView_Previews: PreviewProvider {
    static var blocks = [
        Mock.block2.id:Mock.block2, Mock.block4.id:Mock.block4,
        Mock.block1.id:Mock.block1, Mock.block3.id:Mock.block3
    ]
    static var day = Day(blocks: blocks, date: Date.now)

    static var previews: some View {
        DayView(day: day)
    }
}
