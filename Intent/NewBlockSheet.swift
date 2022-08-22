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
    @State private var bullets: [Bullet]
    
    init(day: Day) {
        self.day = day
        self._newBlock = StateObject(wrappedValue: Block())
        self._bullets = State(wrappedValue: [])
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Block name", text: self.$newBlock.name)
                    DatePicker("Block time", selection: self.$newBlock.time)
                }
                
                Section("Additional Details") {
                    ForEach(self.$bullets) { $bullet in
                        TextField("Bullet point", text: $bullet.text)
                    }
                    
                    Button("Add bullet point") {
                        self.bullets.append(Bullet())
                    }
                }
            }
            .navigationTitle("New Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.bullets = self.bullets.filter{ bullet in
                            !bullet.text.isEmpty
                        }
                        
                        self.newBlock.bullets = self.bullets
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
