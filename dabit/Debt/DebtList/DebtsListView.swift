//
//  DebtsView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI
import CoreData


struct DebtsListView: View {
    @Environment(\.managedObjectContext) var context;
    @FetchRequest(entity: CDDebt.entity(), sortDescriptors: []) var debts: FetchedResults<CDDebt>
    
    let layout = [
        GridItem(.flexible())
    ]
    
    func addItem(title: String, amount: Int32, avatar: String) {
        let debt = CDDebt(context: context);
        debt.id = UUID();
        debt.amount = amount;
        debt.avatar = avatar;
        debt.title = title;
        try? context.save();
    }
    
    var body: some View {
        NavigationView {
            List(debts, id: \.id) { item in
                DebtsListItemView(debt: item)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Debts")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        withAnimation(.spring()) {
                            addItem(title: "Hello", amount: 1000, avatar: "placeholder3")
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
