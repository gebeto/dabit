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
    
    @State var addItemOpened = false;
    
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
    
    func deleteItem(debt: CDDebt) {
        context.delete(debt);
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(debts, id: \.id) { item in
                    DebtsListItemView(debt: item)
                }.onDelete(perform: { indexSet in
                    indexSet.map{ debts[$0] }.forEach(self.deleteItem)
                    try? context.save();
                })
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Debts")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        addItemOpened = true;
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
            .sheet(isPresented: $addItemOpened, content: {
                NavigationView {
                    VStack {
                        CreateAmountView(onAdd: { amount in
                            addItemOpened = false;
                            withAnimation(.spring()) {
                                addItem(title: "Hello", amount: Int32(amount), avatar: "placeholder3")
                            }
                        })
                    }
                    .toolbar(content: {
                        Button(action: {
                            addItemOpened = false;
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                        })
                    })
                }
            })
        }
    }
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsListView()
    }
}
