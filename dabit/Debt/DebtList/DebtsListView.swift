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
        entity: CDPerson.entity(),
        sortDescriptors: [],
        predicate: nil
    ) var persons: FetchedResults<CDPerson>;
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(persons, id: \.self) { person in
                        VStack {
                            if person.avatar == nil {
                                Text("Loading...")
                            } else {
                                DebtsListItemView(person: person)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map{ persons[$0] }.forEach { person in
                            viewContext.delete(person);
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
                    let person = CDPerson(context: viewContext);
                    person.name = "Slavik Nychkalo";
                    person.avatar = "placeholder3";
                    try! viewContext.save();
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 4)
        }
    }
}
