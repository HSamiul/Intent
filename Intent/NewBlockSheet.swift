//
//  NewBlockSheet.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

struct NewBlockSheet: View {
    @ObservedObject private var day: Day
    @StateObject private var newBlock: Block
    
    init(day: Day) {
        self.day = day
        self._newBlock = StateObject(wrappedValue: Block(name: "", time: Date.now))
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Block name", text: self.$newBlock.name)
                DatePicker("Block time", selection: self.$newBlock.time)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.day.blocks.append(newBlock)
                        self.day.newBlockSheetVisible = false
                    } label: {
                        Text("Done")
                            .font(.system(.body, design: .rounded, weight: .semibold))
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.day.newBlockSheetVisible = false
                    } label: {
                        Text("Cancel")
                            .font(.system(.body, design: .rounded))
                    }

                }
            }
        }
    }
}

struct NewBlockSheet_Previews: PreviewProvider {
    static var blocks = [Mock.block1, Mock.block2, Mock.block3]
    static var day = Day(blocks: blocks)
    static var previews: some View {
        NewBlockSheet(day: day)
    }
}
