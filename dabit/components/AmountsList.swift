//
//  AmountsList.swift
//  dabit
//
//  Created by gebeto on 29.08.2021.
//

import SwiftUI

struct AmountsList: View {
    var body: some View {
        List(1..<10) { item in
            VStack(alignment: .leading) {
                Text("$\(item * 100)").font(.body).fontWeight(.semibold)
                Text("After light \(item)").font(.caption).foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}

struct AmountsList_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AmountsList()
        }
        .frame(width:300, height: 400)
        .previewLayout(.sizeThatFits)
    }
}
