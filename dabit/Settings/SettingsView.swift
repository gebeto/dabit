//
//  SettingsView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI
import CoreData




struct ClearStorageButton: View {
    @State var success = false;
    @Environment(\.managedObjectContext) private var viewContext;
    
    func clearCoreData() {
        let fetchRequest = CDPerson.fetchRequest()
        fetchRequest.includesPropertyValues = false
        let context = viewContext;
        let objects = try! context.fetch(fetchRequest);
        for object in objects {
            context.delete(object)
        }
        try! context.save();
    }

    
    var body: some View {
        Button(role: .destructive) {
            clearCoreData();
        } label: {
            Label("Clear storage", systemImage: "trash").accentColor(.red)
        }
    }
}


struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Storage")) {
                    ClearStorageButton()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
