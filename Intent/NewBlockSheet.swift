//
//  NewBlockSheet.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

struct NewBlockSheet: View {
    @ObservedObject private var day: Day
    @State private var showingAlert = false
    
    @State private var name: String = ""
    @State private var time: Date = Date.now
    @State private var bullets: [Bullet] = []
    
    init(day: Day) {
        self.day = day
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Block name", text: self.$name)
                    DatePicker("Block time", selection: self.$time)
                }
                
                Section("Additional Details") {
                    ForEach(self.$bullets) { bullet in
                        TextField("Bullet point", text: bullet.text)
                    }
                    
                    Button("Add bullet point") {
                        self.bullets.append(Bullet(""))
                    }
                }
            }
            .navigationTitle("New Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (self.name.isBlank) {
                            self.showingAlert = true
                            return
                        }
                        self.name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        self.bullets = self.bullets.filter { bullet in
//                            !bullet.text.isBlank
//                            !bullet.text.trimmingCharacters(in: .whitespaces).isEmpty
                            !bullet.text.isBlank
                        }
                        print("Bullets: \(self.bullets.count)")
                        self.day.addBlock(name: self.name, time: self.time, bullets: self.bullets)
//                        self.day.blocks.updateValue(block, forKey: block.id)
//                        self.day.blocks[block.id] = block
                        self.day.newBlockSheetVisible = false
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                    .alert("You must enter a name for the block.", isPresented: self.$showingAlert) {}

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.day.newBlockSheetVisible = false
                    } label: {
                        Text("Cancel")
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
