//
//  DebtsView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI
import CoreData


struct DebtsListView: View {
    @Environment(\.managedObjectContext) var moc;
    @FetchRequest(entity: CDDebt.entity(), sortDescriptors: []) var debts: FetchedResults<CDDebt>
    
    let layout = [
        GridItem(.flexible())
    ]
    
    func addItem(item: DebtItem) {
        let debt = CDDebt(context: moc);
        debt.id = UUID();
        debt.amount = 1000;
        debt.avatar = item.avatar;
        debt.title = item.title;
        try? moc.save();
    }
    
    var body: some View {
        NavigationView {
            List(debts, id: \.id) { item in
                DebtsListItemView(debt: DebtItem.init(debt: item))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Debts")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        print("Add")
                        withAnimation(.spring()) {
                            addItem(item: DebtItem.init(title: "Test", avatar: "placeholder2", amount: 1000))
                        }
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                    })
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink(
                        destination: Text("Settings"),
                        label: {
                            Button(action: {
                                print("Settings")
                            }, label: {
                                Image(systemName: "gear")
                                    .foregroundColor(.accentColor)
                            })
                        })
                })
            })
        }
    }
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsListView()
    }
}
