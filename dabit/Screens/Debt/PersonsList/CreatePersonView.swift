//
//  CreatePersonView.swift
//  dabit
//
//  Created by gebeto on 08.01.2022.
//

import SwiftUI

struct CreatePersonView: View {
    enum FocusField: Hashable {
        case userName
        case test
        case none
    }
    
    @FocusState private var focusedField: FocusField?
    @State var userName = ""
    @State var addUser = false
    
    var handleSubmit: (String) -> Void
    
    func submit() {
        handleSubmit(userName)
        userName = ""
        addUser.toggle()
    }
    
    var body: some View {
        VStack {
            if addUser {
                TextField("User name", text: $userName)
                    .focused($focusedField, equals: .userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        submit()
                        addUser.toggle()
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
