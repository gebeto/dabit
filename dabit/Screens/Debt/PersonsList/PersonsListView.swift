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
    @State var userName = "";
    @State var addUser = false;
    
    enum FocusField: Hashable {
        case userName
        case test
        case none
    }
    
    @FocusState private var focusedField: FocusField?
    
    @Environment(\.managedObjectContext) private var viewContext;
    
    @FetchRequest(
        entity: Person.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.timestamp, ascending: false)]
    ) var persons: FetchedResults<Person>;
    
    let layout = [
        GridItem(.flexible())
    ]
    
    func submit() {
        addUser.toggle()
        withAnimation(.spring()) {
            let person = Person(context: viewContext);
            person.name = userName;
            userName = "";
            person.avatar = "placeholder3";
            person.timestamp = Date();
            try! viewContext.save();
        }
    }
    
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
            VStack {
                if addUser {
                    TextField("User name", text: $userName)
                        .focused($focusedField, equals: .userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            submit()
                        }
                }
                DButton(title: "Add user", systemIcon: "plus.circle.fill") {
                    if addUser {
                       submit()
                    } else {
                        addUser.toggle()
                        focusedField = .userName
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
            .padding(.top, 4)
        }
    }
}
