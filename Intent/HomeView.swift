//
//  MasterView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/11/22.
//

import SwiftUI

class Home: ObservableObject {
    @Published var days: [Day]
    @Published var selectedDay: Day
    
    init(days: [Day] = [], selectedDay: Day) {
        self.days = days
        self.selectedDay = selectedDay
    }
}

struct HomeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
