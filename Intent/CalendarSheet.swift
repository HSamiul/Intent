//
//  test.swift
//  Intent
//
//  Created by Samiul Hoque on 9/22/22.
//

// TODO: Choose better dict key than this stringy mess
// TODO: Finish writing this sheet and attach to HomeView

import SwiftUI

struct CalendarSheet: View {
    @ObservedObject private var home: Home
    @State private var date: Date
    
    init(home: Home) {
        self.home = home
        self._date = State(wrappedValue: home.selectedDay)
    }
    
    var body: some View {
        NavigationView {
            DatePicker("Test", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(.horizontal)
                .toolbar {
                    Button {
                        home.addDay(date: date)
                        home.selectedDay = date
                        home.calendarSheetVisible = false
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
        }
    }
}

struct CalendarSheet_Previews: PreviewProvider {
    static var home = Home()
    
    static var previews: some View {
        CalendarSheet(home: home)
    }
}

