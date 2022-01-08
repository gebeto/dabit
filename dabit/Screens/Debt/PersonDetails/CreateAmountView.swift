//
//  CreatePersonView.swift
//  dabit
//
//  Created by gebeto on 08.01.2022.
//

import SwiftUI

struct CreateAmountView: View {
    enum FocusField: Hashable {
        case amount
        case test
        case none
    }
    
    @FocusState private var focusedField: FocusField?
    @State var amount = ""
    @State var opened = false
    
    var handleSubmit: (Int) -> Void
    
    func submit() {
        let _amount = Int(amount) ?? 0
        if _amount > 0 {
            handleSubmit(_amount)
        }
        amount = ""
        opened.toggle()
    }
    
    var body: some View {
        VStack {
            if opened {
                TextField("$100", text: $amount)
                    .keyboardType(.decimalPad)
                    .font(Font.system(size: 36))
                    .multilineTextAlignment(.center)
                    .focused($focusedField, equals: .amount)
                    .onSubmit {
                        submit()
                    }
            }
            DButton(title: "Add amount", systemIcon: "plus.circle.fill") {
                if opened {
                    submit()
                } else {
                    opened.toggle()
                    focusedField = .amount
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
        .padding(.top, 4)
    }
}
