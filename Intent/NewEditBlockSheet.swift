//
//  NewEditBlockSheet.swift
//  Intent
//
//  Created by Samiul Hoque on 9/29/22.
//

import SwiftUI

// If a block is passed in, edit. If not, new
struct NewEditBlockForm: View {
    @ObservedObject private var day: Day
    @ObservedObject private var block: Block // could or could not be passed in
    @StateObject private var transientBlock: Block // always here, the block being modified
    @State private var showingAlert = false
    
    init(day: Day, block: Block) {
        self.day = day
        self.block = block
        self._transientBlock = StateObject(wrappedValue: Block(name: block.name, date: block.date, bullets: block.bullets))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Block name", text: self.$transientBlock.name)
                    DatePicker("Block time", selection: self.$transientBlock.date)
                }
                
                Section("Additional Details") {
                    ForEach(self.$transientBlock.bullets) { bullet in
                        TextField("Bullet point", text: bullet.text)
                    }
                    
                    Button("Add bullet point") {
                        self.transientBlock.bullets.append(Bullet(""))
                    }
                }
            }
        }
    }
}

struct NewEditBlockForm_Previews: PreviewProvider {
    static var day = Day(blocks: [:], date: Date.now)
    
    static var previews: some View {
        NewEditBlockForm(day: day, block: Mock.block4)
    }
}
