//
//  MasterView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

class Home: ObservableObject {
    @Published var days: Dictionary<Date, Day>
    @Published var selectedDay: Date
    @Published var calendarSheetVisible = false
    
    init() {
        let date = Date()
        
        days = [date:Day(date: date)]
        selectedDay = date
    }
    
    func getDayFrom(date: Date) -> Day {
        for key in days.keys {
            let cmp = Calendar.current.compare(date, to: key, toGranularity: .day)
            if (cmp == .orderedSame) {
                return days[key]!
            }
        }
        
        print("I SHOULD NEVER HAPPEN")
        return Day(date: Date.now)
    }
    
    func addDay(date: Date) -> Void {
        guard !dayExists(date: date) else { print("already exists"); return }
        print("adding")
        days.updateValue(Day(date: date), forKey: date)
    }
    
    func dayExists(date: Date) -> Bool {
        for key in days.keys {
            let cmp = Calendar.current.compare(date, to: key, toGranularity: .day)
            if (cmp == .orderedSame) {
                return true
            }
        }
        return false
    }
}

struct HomeView: View {
    @StateObject private var home = Home()
    
    var body: some View {
        NavigationView {
            DayView(day: home.getDayFrom(date: home.selectedDay))
//                .padding(.vertical)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                    } label: {
                        Image(systemName: "person.crop.circle")
                    }
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        self.home.calendarSheetVisible = true

                    } label: {
                        Image(systemName: "calendar")
                    }
                }
            }
        }
        .sheet(isPresented: self.$home.calendarSheetVisible) {
            CalendarSheet(home: self.home)
                .presentationDetents([.fraction(0.50)])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
