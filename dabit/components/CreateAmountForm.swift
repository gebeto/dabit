//
//  CreateAmountForm.swift
//  dabit
//
//  Created by gebeto on 14.11.2021.
//

import SwiftUI

enum CreateAmountFormFocus {
    case amount;
    case comment;
}

struct CreateAmountForm: View {
    @FocusState var focus: CreateAmountFormFocus?
    
    @State var amount: String = "";
    @State var comment: String = "";
    
    let onAdd: (Int) -> Void;
    
    var body: some View {
        VStack {
            Form {
                TextField("Sum", text: $amount)
                    .keyboardType(.decimalPad)
                    .font(Font.system(size: 36))
                    .multilineTextAlignment(.center)
                    .focused($focus, equals: .amount)
                    .padding(.vertical, 20)
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.focus = .amount;
                       }
                    }
                
                TextField("Comment", text: $comment)
                    .focused($focus, equals: .comment)

            }
            
            Button(role: .none) {
                if focus == .amount {
                    focus = .comment
                } else if (focus == .comment) {
                    let amount = Int(amount) ?? 0
                    if amount > 0 {
                        self.onAdd(amount);
                    }
                }
            } label: {
                Label("Add", systemImage: "checkmark.circle.fill")
            }
            .buttonStyle(.bordered)
        }
    }
}

struct CreateAmountForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateAmountForm { amount in
            print("Amount: \(amount)")
        }
    }
}
