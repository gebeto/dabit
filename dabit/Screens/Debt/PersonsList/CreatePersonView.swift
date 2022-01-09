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
        case none
    }
    
    @FocusState private var focusedField: FocusField?
    @State var userName = ""
    @State var addUser = false
    
    var handleSubmit: (String) -> Void
    
    func toggleCreate() {
        focusedField = addUser ? FocusField.none : FocusField.userName
        withAnimation(.spring()) {
            addUser.toggle()
        }
    }
    
    func submit() {
        if !userName.isEmpty {
            handleSubmit(userName)
        }
        userName = ""
        toggleCreate()
    }
    
    var body: some View {
        VStack {
            if addUser {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(0..<10) {
                            Text("Item \($0)")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .foregroundColor(.white)
                                .font(.body)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(0.3), lineWidth: 4))
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                        }
                    }
                }
                TextField("User name", text: $userName)
                    .focused($focusedField, equals: .userName)
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(0.3), lineWidth: 4))
                    .cornerRadius(10)
                    .transition(
                        .move(edge: .bottom)
                            .combined(with: .opacity)
                    )
                    .onSubmit {
                        submit()
                    }
            } else {
                DButton(title: "Add user", systemIcon: "plus.circle.fill") {
                    if addUser {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                        submit()
                    } else {
                        toggleCreate()
                    }
                }
            }
        }
        .padding(12)
    }
}
