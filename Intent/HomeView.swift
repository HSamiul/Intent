//
//  MasterView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

class Home: ObservableObject {
    @Published var days: [Day]
    @Published var selectedDay: Date
    @Published var calendarSheetVisible = false
    
    init() {
        let date = Date()
        
        days = [Day(date: date)]
        selectedDay = date
    }
    
    func getDayFrom(date: Date) {
            
    }
    
    func addDay(date: Date) {
        let dayAlreadyExists = days.contains { day in
            Calendar.current.isDate(day.date, equalTo: date, toGranularity: .day)
        }
        
        guard !dayAlreadyExists else { return }
        days.append(Day(date: date))
    }
}

struct HomeView: View {
    @StateObject private var home = Home()
    
    var body: some View {
        NavigationView {
            DayView(day: self.home.days.first(where: { day in
                Calendar.current.isDate(day.date, equalTo: self.home.selectedDay, toGranularity: .day)
            })!)
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
