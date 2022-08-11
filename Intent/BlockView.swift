//
//  Block.swift
//  Intent
//
//  Created by Samiul Hoque on 8/10/22.
//

import SwiftUI

// TODO: Require that name is not an empty string

class Block: ObservableObject {
    @Published var name: String
    @Published var time: Date
    
    init(name: String = "", time: Date = Date.now) {
        self.name = name
        self.time = time
    }
}

struct BlockView: View {
    @ObservedObject private var block: Block
    
    init(block: Block) {
        self.block = block
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(block.time.formatted())
                    .foregroundColor(.gray)
                    .font(.system(.caption, design: Constants.fontDesign)).bold()
                Text(block.name)
                    .font(.system(.headline, design: Constants.fontDesign))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CircleButton(systemName: "plus")
                .padding()
        }
        .background(.regularMaterial)
        .cornerRadius(10)
//        .shadow(radius: 5)
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(block: Block(name: "Birthday Party", time: Date.now))
            .padding()
    }
}

