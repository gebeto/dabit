//
//  ContentView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI


struct ContentView: View {
    @State var isShown = false;
    
    var body: some View {
        PersonsListView()
            .tabItem {
                Image(systemName: "house")
                Text("Debts")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
