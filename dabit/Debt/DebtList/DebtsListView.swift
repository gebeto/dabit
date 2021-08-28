//
//  DebtsView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI


struct DebtsListView: View {
    @State var data = Array(1...3).map{ DebtItem(title: "Item \($0)", avatar: "placeholder-default", amount: 100) }
    
    let layout = [
        GridItem(.flexible())
    ]
    
    func addItem(item: DebtItem) {
        data.append(item);
    }
    
    var body: some View {
        NavigationView {
            List(data, id: \.self.title) { item in
                DebtsListItemView(debt: item)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Debts")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        print("Add")
                        withAnimation(.spring()) {
                            addItem(item: DebtItem(title: "Test", avatar: "placeholder2", amount: 1000))
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
