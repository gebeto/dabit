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
            Label(title, systemImage: systemIcon)
                .foregroundColor(.white)
                .font(.body.bold())
                .imageScale(.large)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
        })
        .background(Color(.systemBlue))
        .cornerRadius(12)
    }
}

struct DButton_Previews: PreviewProvider {
    static var previews: some View {
        DButton(title: "Test", systemIcon: "plus.circle.fill", action: {
            print("Hello")
        }).previewLayout(.sizeThatFits)
    }
}
