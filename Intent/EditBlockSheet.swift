//
//  EditBlockView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

struct EditBlockSheet: View {
    @ObservedObject private var day: Day
    @ObservedObject private var block: Block
    @StateObject private var transientBlock: Block
    @State private var showingAlert = false
    
    init(day: Day, block: Block) {
        self.day = day
        self.block = block
        self._transientBlock = StateObject(wrappedValue: Block(name: block.name, time: block.time, bullets: block.bullets))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Block name", text: self.$transientBlock.name)
                    DatePicker("Block time", selection: self.$transientBlock.time)
                }
                
                Section("Additional Details") {
                    ForEach(self.$transientBlock.bullets) { bullet in
                        TextField("Bullet point", text: bullet.text)
                    }
                    
                    Button("Add bullet point") {
                        self.transientBlock.bullets.append(Bullet(""))
                    }
                }
                
                Button("Delete") {
                    self.day.blocks.removeValue(forKey: self.block.id)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
            }
//            .scrollContentBackground(.visible)
            .navigationTitle("Edit Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (self.transientBlock.name.isBlank) {
                            self.showingAlert = true
                            return
                        }
                        self.transientBlock.name = self.transientBlock.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        self.block.name = self.transientBlock.name
                        self.block.time = self.transientBlock.time
                        self.block.bullets = self.transientBlock.bullets.filter { bullet in
                            !bullet.text.isEmpty
                        }
                        self.block.editBlockSheetVisible = false
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                    .alert("You must enter a name for the block.", isPresented: self.$showingAlert) {
                         
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.block.editBlockSheetVisible = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct EditBlockSheet_Previews: PreviewProvider {
    static var day = Day(blocks: [:], date: Date.now)
    
    static var previews: some View {
        EditBlockSheet(day: day, block: Mock.block4)
    }
}
