//
//  AmountsList.swift
//  dabit
//
//  Created by gebeto on 29.08.2021.
//

import SwiftUI

struct AmountsList: View {
    var items: [CDAmount];
    
    var body: some View {
        List(items, id: \.self.id) { item in
            VStack(alignment: .leading) {
                Text("$\(item.amount)")
                    .font(.body)
                    .fontWeight(.semibold)
                if item.createdAt != nil {
                    Text("After light \(item.createdAt!, formatter: DateFormatter())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .listStyle(DefaultListStyle())
    }
}

struct AmountsList_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AmountsList(items: [])
        }
        .frame(width:300, height: 400)
        .previewLayout(.sizeThatFits)
    }
}
