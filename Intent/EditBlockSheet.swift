//
//  EditBlockView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

struct EditBlockSheet: View {
    @ObservedObject private var oldBlock: Block
    @StateObject private var newBlock: Block
    
    init(oldBlock: Block) {
        self.oldBlock = oldBlock
        self._newBlock = StateObject(wrappedValue: Block(name: oldBlock.name, time: oldBlock.time))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Block name", text: self.$newBlock.name)
                    DatePicker("Block time", selection: self.$newBlock.time)
                }
            }
            .navigationTitle("Edit Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.oldBlock.name = self.newBlock.name
                        self.oldBlock.time = self.newBlock.time
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
    static var oldBlock = Block(name: "Make breakfast", time: Date.now)
    
    static var previews: some View {
        EditBlockSheet(oldBlock: oldBlock)
    }
}
