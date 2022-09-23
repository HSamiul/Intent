//
//  MasterView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

class Home: ObservableObject {
    @Published var days: [Day]
    @Published var selectedDate: Date
    @Published var chooseDaySheetVisible = false
    
    init(days: [Day] = [], selectedDate: Date = Date.now) {
        self.days = days
        self.selectedDate = selectedDate
    }
}


struct HomeView: View {
    @ObservedObject private var home = Home()
    
    var body: some View {
        NavigationView {
            DayView(day: Day(blocks: [Mock.block1, Mock.block2]))
                .padding(.vertical)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                        } label: {
                            Image(systemName: "person.crop.circle")
                        }
                    }

                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            self.home.chooseDaySheetVisible = true

                        } label: {
                            Image(systemName: "calendar")
                        }
                    }
                }
        }
        .sheet(isPresented: self.$home.chooseDaySheetVisible) {
            DatePicker("Test", selection: self.$home.selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
                .presentationDetents([.fraction(0.50)])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
