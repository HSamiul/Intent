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
    @Binding private var isOpen: Bool
    
    init(oldBlock: Block, isOpen: Binding<Bool>) {
        self.oldBlock = oldBlock
        self._newBlock = StateObject(wrappedValue: Block(name: oldBlock.name, time: oldBlock.time))
        self._isOpen = isOpen
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Block name", text: self.$newBlock.name)
                DatePicker("Block time", selection: self.$newBlock.time)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.oldBlock.name = self.newBlock.name
                        self.oldBlock.time = self.newBlock.time
                        self.isOpen = false
                    } label: {
                        Text("Done")
                            .font(.system(.body, design: .rounded, weight: .semibold))
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.isOpen = false
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
        EditBlockSheet(oldBlock: oldBlock, isOpen: .constant(true))
    }
}
