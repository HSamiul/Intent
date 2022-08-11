//
//  ButtonViews.swift
//  Intent
//
//  Created by Samiul Hoque on 8/10/22.
//

import SwiftUI

struct CircleButton: View {
    private var systemName: String
    
    init(systemName: String) {
        self.systemName = systemName
    }
    
    var body: some View {
        Button(action: {}) {
            Image(systemName: self.systemName)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(systemName: "plus")
    }
}
