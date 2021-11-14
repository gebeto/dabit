//
//  DebtsView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI
import CoreData


struct DebtsListView: View {
    @State var isSettingsOpened = false;
    
    @Environment(\.managedObjectContext) private var viewContext;
    
    @FetchRequest(
        entity: CDDebt.entity(),
        sortDescriptors: [],
        predicate: nil
    ) var debts: FetchedResults<CDDebt>;
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(debts, id: \.self) { item in
                        VStack {
                            if item.avatar == nil {
                                Text("Loading...")
                            } else {
                                DebtsListItemView(debt: item)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map{ debts[$0] }.forEach { debt in
                            viewContext.delete(debt);
                        };
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Debts")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        NavigationLink(
                            destination: Text("Settings"),
                            label: {
                                Button(action: {
                                    print("Settings");
                                    isSettingsOpened = true;
                                }, label: {
                                    Image(systemName: "gear")
                                        .foregroundColor(.accentColor)
                                })
                            })
                    })
                })
                .sheet(isPresented: $isSettingsOpened) {
                    isSettingsOpened = false;
                } content: {
                    SettingsView()
                }

            }
            DButton(title: "Add user", systemIcon: "plus.circle.fill") {
                withAnimation(.spring()) {
                    let dd = CDDebt(context: viewContext);
                    dd.title = "Slavik Nychkalo";
                    dd.avatar = "placeholder3";
                    try! viewContext.save();
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 4)
        }
    }
}
