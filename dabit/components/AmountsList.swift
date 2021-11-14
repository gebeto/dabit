//
//  AmountsList.swift
//  dabit
//
//  Created by gebeto on 29.08.2021.
//

import SwiftUI

struct AmountsList: View {
    var person: CDPerson;
    @Environment(\.managedObjectContext) private var viewContext;
    @FetchRequest var items: FetchedResults<CDAmount>;

    init(person: CDPerson) {
        self.person = person;
        self._items = FetchRequest(
            entity: CDAmount.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \CDAmount.timestamp, ascending: false)],
            predicate: NSPredicate(format: "person == %@", person)
        )
    }
    
    var body: some View {
        List(items, id: \.self) { item in
            VStack(alignment: .leading) {
                Text("$\(item.amount)")
                    .font(.body)
                    .fontWeight(.semibold)
                if item.timestamp != nil {
                    Text("After light \(item.timestamp!, formatter: DateFormatter())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .listStyle(DefaultListStyle())
    }
}
