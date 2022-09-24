//
//  NewBlockSheet.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

extension String {
    var isBlank: Bool {
        for char in self {
            if !char.isWhitespace {
                return false
            }
        }
        return true
    }
}

struct NewBlockSheet: View {
    @ObservedObject private var day: Day
    @StateObject private var newBlock: Block
    @State private var showingAlert = false
    
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
                        self.newBlock.bullets.append(Bullet(""))
                    }
                }
            }
            .navigationTitle("New Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (self.newBlock.name.isBlank) {
                            self.showingAlert = true
                            return
                        }
                        self.newBlock.name = self.newBlock.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        self.newBlock.bullets = self.newBlock.bullets.filter { bullet in
                            !bullet.text.isEmpty
                        }
                        self.day.blocks[newBlock.id] = newBlock
                        self.day.newBlockSheetVisible = false
                    } label: {
                        Text("Done")
                            .font(.system(.body, design: .rounded, weight: .semibold))
                    }
                    .alert("You must enter a name for the block.", isPresented: self.$showingAlert) {}

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
    static var day = Day(blocks: [:], date: Date.now)
    static var previews: some View {
        NewBlockSheet(day: day)
    }
}
