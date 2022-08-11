//
//  ButtonViews.swift
//  Intent
//
//  Created by Samiul Hoque on 8/10/22.
//

import SwiftUI

struct CircleButton: View {
    private var systemName: String
    private var action: () -> Void
    
    init(systemName: String, action: @escaping () -> Void) {
        self.systemName = systemName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: self.systemName)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(systemName: "plus", action: {})
    }
}
