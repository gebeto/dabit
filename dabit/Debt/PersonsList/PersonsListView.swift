//
//  DebtsView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI
import CoreData


struct PersonsListView: View {
    @State var isSettingsOpened = false;
    
    @Environment(\.managedObjectContext) private var viewContext;
    
    @FetchRequest(
        entity: CDPerson.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDPerson.timestamp, ascending: false)]
    ) var persons: FetchedResults<CDPerson>;
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(persons, id: \.self) { person in
                        PersonsListItemView(person: person)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                                Button {
                                    withAnimation {
                                        viewContext.delete(person);
                                        try! viewContext.save();
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }.tint(.red)
                            })
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
                    person.timestamp = Date();
                    try! viewContext.save();
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 4)
        }
    }
}
