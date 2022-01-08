//
//  AmountsList.swift
//  dabit
//
//  Created by gebeto on 29.08.2021.
//

import SwiftUI

struct AmountsList: View {
    var person: Person;
    @Environment(\.managedObjectContext) private var viewContext;
    @FetchRequest var items: FetchedResults<Amount>;

    init(person: Person) {
        self.person = person;
        self._items = FetchRequest(
            entity: Amount.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Amount.timestamp, ascending: false)
            ],
            predicate: NSPredicate(format: "person == %@", person)
        )
    }
    
    var body: some View {
        List(items, id: \.self) { item in
            HStack {
                Image(systemName: item.done ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(item.done ? .green : .red)
                VStack(alignment: .leading) {
                    Text("$\(item.amount)")
                        .font(.body)
                        .fontWeight(.semibold)
                        .strikethrough(item.done)
                    Text("After light \(item.timestamp!, formatter: DateFormatter())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    withAnimation {
                        item.done = !item.done;
                        item.person?.addToAmounts(item);
                        try! viewContext.save();
                    }
                } label: {
                    Label("Done", systemImage: item.done ? "xmark" : "checkmark")
                }.tint(item.done ? .red : .green)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    withAnimation {
                        viewContext.delete(item);
                        try! viewContext.save();
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }.tint(.red)
            }
        }
        .listStyle(DefaultListStyle())
    }
}
