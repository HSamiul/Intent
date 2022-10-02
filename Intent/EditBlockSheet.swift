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
    
    @State private var name: String
    @State private var date: Date
    @State private var bullets: [Bullet]
    @State private var showingAlert = false
    
    init(day: Day, block: Block) {
        self.day = day
        self.block = block
        
        self._name = State(wrappedValue: block.name)
        self._date = State(wrappedValue: block.date)
        self._bullets = State(wrappedValue: block.bullets)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Block name", text: $name)
                    DatePicker("Block time", selection: $date, displayedComponents: .hourAndMinute)
                }
                
                Section("Additional Details") {
                    ForEach($bullets) { bullet in
                        TextField("Bullet point", text: bullet.text)
                    }
                    
                    Button("Add bullet point") {
                        bullets.append(Bullet(""))
                    }
                }
                
                Button("Delete") {
                    day.blocks.removeValue(forKey: block.id)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.red)
            }
//            .scrollContentBackground(.visible)
            .navigationTitle("Edit Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (name.isBlank) {
                            showingAlert = true
                        } else {
                            block.update(name: name, date: date, bullets: bullets)
                            self.block.editBlockSheetVisible = false
                        }
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                    .alert("You must enter a name for the block.", isPresented: $showingAlert) {
                         
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
