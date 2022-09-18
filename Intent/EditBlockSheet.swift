//
//  EditBlockView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

struct EditBlockSheet: View {
    @ObservedObject private var day: Day
    @ObservedObject private var oldBlock: Block
    @StateObject private var newBlock: Block
    
    init(day: Day, oldBlock: Block) {
        self.day = day
        self.oldBlock = oldBlock
        self._newBlock = StateObject(wrappedValue: Block(name: oldBlock.name, time: oldBlock.time, bullets: oldBlock.bullets))
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
                
                Button("Delete") {
                    self.day.blocks = self.day.blocks.filter { block in
                        self.oldBlock.id != block.id
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)

            }
            .scrollContentBackground(.visible)
            .navigationTitle("Edit Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.oldBlock.name = self.newBlock.name
                        self.oldBlock.time = self.newBlock.time
                        self.oldBlock.bullets = self.newBlock.bullets.filter { bullet in
                            !bullet.text.isEmpty
                        }
                        self.oldBlock.editBlockSheetVisible = false
                    } label: {
                        Text("Done")
                            .font(.system(.body, design: .rounded, weight: .semibold))
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.oldBlock.editBlockSheetVisible = false
                    } label: {
                        Text("Cancel")
                            .font(.system(.body, design: .rounded))
                    }

                }
            }
        }
    }
}

struct EditBlockSheet_Previews: PreviewProvider {
    static var day = Day(blocks: [])
    
    static var previews: some View {
        EditBlockSheet(day: day, oldBlock: Mock.block4)
    }
}
