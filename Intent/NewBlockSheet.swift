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
        self._newBlock = StateObject(wrappedValue: Block())
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Block name", text: self.$newBlock.name)
                    DatePicker("Block time", selection: self.$newBlock.time)
                }
                
                Section("Additional Details") {
                    ForEach(self.$newBlock.bullets) { $bullet in
                        TextField("Bullet point", text: $bullet.text)
                    }
                    
                    Button("Add bullet point") {
                        self.newBlock.bullets.append(Bullet())
                    }
                }
            }
            .navigationTitle("New Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.newBlock.bullets = self.newBlock.bullets.filter { bullet in
                            !bullet.text.isEmpty
                        }
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
