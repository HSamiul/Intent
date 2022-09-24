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
    @State private var showingAlert = false
    
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
                    ForEach(self.$newBlock.bullets) { bullet in
                        TextField("Bullet point", text: bullet.text)
                    }
                    
                    Button("Add bullet point") {
                        self.newBlock.bullets.append(Bullet(""))
                    }
                }
                
                Button("Delete") {
                    self.day.blocks.removeValue(forKey: self.oldBlock.id)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)

            }
            .scrollContentBackground(.visible)
            .navigationTitle("Edit Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (self.newBlock.name.isBlank) {
                            self.showingAlert = true
                            return
                        }
                        self.newBlock.name = self.newBlock.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        self.newBlock.name = self.newBlock.name.trimmingCharacters(in: .whitespacesAndNewlines)
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
                    .alert("You must enter a name for the block.", isPresented: self.$showingAlert) {}

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
    static var day = Day(blocks: [:], date: Date.now)
    
    static var previews: some View {
        EditBlockSheet(day: day, oldBlock: Mock.block4)
    }
}
