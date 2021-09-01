//
//  DebtsView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI
import CoreData


struct DebtsListView: View {
    @StateObject private var viewModel: DebtsListViewModel = DebtsListViewModel();
    @State var isAddUserShown = false;
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.debts, id: \.objectID) { item in
                    if item.avatar == nil {
                        Text("Loading...")
                    } else {
                        DebtsListItemView(debt: item)
                    }
                }
                .onDelete(perform: self.viewModel.deleteItems)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Debts")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        withAnimation(.spring()) {
                            viewModel.addItem(title: "Slavik Nychkalo", avatar: "placeholder3")
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
//            .sheet(isPresented: $isAddItem, content: {
//                NavigationView {
//                    VStack {
//                        viewModel.addItem(title: "Slavik Nychkalo", amount: Int32(amount), avatar: "placeholder3")
//                        CreateAmountView(onAdd: { amount in
//                            isAddItem = false;
//                            withAnimation(.spring()) {
//                                viewModel.addItem(title: "Slavik Nychkalo", amount: Int32(amount), avatar: "placeholder3")
//                            }
//                        })
//                    }
//                    .toolbar(content: {
//                        Button(action: {
//                            isAddItem = false;
//                        }, label: {
//                            Image(systemName: "xmark.circle.fill")
//                        })
//                    })
//                }
//            })
        }.onAppear(perform: {
            viewModel.fetchItems()
        })
    }
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsListView()
    }
}
