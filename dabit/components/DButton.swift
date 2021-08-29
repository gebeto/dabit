//
//  DButton.swift
//  dabit
//
//  Created by gebeto on 29.08.2021.
//

import SwiftUI


struct DButton: View {
    let title: String;
    let systemIcon: String;
    let action: () -> Void;
    
    var body: some View {
        Button(action: {
            print("Add more")
        }, label: {
            Spacer()
            Label(title, systemImage: systemIcon)
                .foregroundColor(.accentColor)
                .font(.body.bold())
                .imageScale(.large)
            Spacer()
        })
        .padding()
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.04))
        .cornerRadius(8)
    }
}

struct DButton_Previews: PreviewProvider {
    static var previews: some View {
        DButton(title: "Test", systemIcon: "plus.circle.fill", action: {
            print("Hello")
        }).previewLayout(.sizeThatFits)
    }
}
