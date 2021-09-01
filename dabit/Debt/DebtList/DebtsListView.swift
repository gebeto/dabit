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
        VStack {
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
            }.onAppear(perform: {
                viewModel.fetchItems()
            })
            DButton(title: "Add user", systemIcon: "plus.circle.fill") {
                withAnimation(.spring()) {
                    viewModel.addItem(title: "Slavik Nychkalo", avatar: "placeholder3")
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 4)
        }
    }
}

struct DebtsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsListView()
    }
}
