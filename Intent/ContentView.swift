//
//  ContentView.swift
//  Intent
//
//  Created by Samiul Hoque on 8/10/22.
//

import SwiftUI

struct ContentView: View {
    let day = Day(blocks: [:], date: Date.now)
    var body: some View {
//        HomeView()
        DayView(day: day)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
