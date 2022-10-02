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
    @State private var date: Date
    @State private var bullets: [Bullet] = []
    
    init(day: Day) {
        self.day = day
        self._date = State(wrappedValue: day.date)
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
            }
            .navigationTitle("New Block")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if (name.isBlank) {
                            showingAlert = true
                        } else {
                            _ = day.addBlock(name: name, date: date, bullets: bullets)
                            day.newBlockSheetVisible = false
                        }
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
