//
//  AmountsList.swift
//  dabit
//
//  Created by gebeto on 29.08.2021.
//

import SwiftUI

struct AmountsList: View {
    var debt: CDDebt;
    @Environment(\.managedObjectContext) private var viewContext;
    @FetchRequest var items: FetchedResults<CDAmount>;

    init(debt: CDDebt) {
        self.debt = debt;
        self._items = FetchRequest(
            entity: CDAmount.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \CDAmount.createdAt, ascending: false)],
            predicate: NSPredicate(format: "debt == %@", debt)
        )
    }
    
    var body: some View {
        List(items, id: \.self) { item in
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
