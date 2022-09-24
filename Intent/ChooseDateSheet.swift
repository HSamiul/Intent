//
//  test.swift
//  Intent
//
//  Created by Samiul Hoque on 9/22/22.
//

// TODO: Choose better dict key than this stringy mess
// TODO: Finish writing this sheet and attach to HomeView

import SwiftUI

struct ChooseDateSheet: View {
    @ObservedObject private var home: Home
    @State private var date = Date.now
    
    init(home: Home) {
        self.home = home
    }
    
    var body: some View {
        NavigationView {
            DatePicker("Test", selection: self.$date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(.horizontal)
                .toolbar {
                    Button {
                        if (!self.home.days.contains(where: { day in
                            Calendar.current.isDate(day.date, equalTo: self.date, toGranularity: .day)
                        })) {
                            print("I happened")
                            self.home.days.append(Day(blocks: [:], date: self.date))
                            
                        }
                        print("bruddah")
                        self.home.selectedDate = self.date
                        self.home.chooseDaySheetVisible = false
                    } label: {
                        Text("Close")
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
        }
    }
}

struct test_Previews: PreviewProvider {
    static var home = Home()
    
    static var previews: some View {
        ChooseDateSheet(home: home)
    }
}

