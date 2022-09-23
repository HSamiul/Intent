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
    
    init(days: [Day] = [Day(blocks: [], date: Date(/*create a date with time 0:00*/))], selectedDate: Date = Date.now) {
        self.days = days
        self.selectedDate = selectedDate
    }
    
    func getDayFrom(date: Date) {
            
    }
}

struct HomeView: View {
    @StateObject private var home = Home()
    
    var body: some View {
        NavigationView {
            DayView(day: self.home.days.first(where: { day in
                Calendar.current.isDate(day.date, equalTo: self.home.selectedDate, toGranularity: .day)
            })!)
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
            ChooseDateSheet(home: self.home)
                .presentationDetents([.fraction(0.50)])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
