//
//  DebtItemView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI


struct DebtItemView: View {
    let debt: DebtItem;
    
    @State var opened = false;
    
    var body: some View {
        HStack {
            Image(debt.avatar)
                .resizable()
                .frame(width: 48, height: 48, alignment: .center)
                .cornerRadius(24)
            VStack(alignment: .leading, spacing: 4) {
                Text(debt.title)
                    .fontWeight(.semibold)
                Text("Amount: \(debt.amount)")
                    .fontWeight(.regular)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
                .padding(16)
        }
        .onTapGesture(perform: {
            opened = true;
        })
        .sheet(isPresented: $opened, content: {
            DebtDetailView(debt: debt)
        })
    }
}


struct DebtItemView_Previews: PreviewProvider {
    static var previews: some View {
        DebtItemView(debt: DebtItem(title: "Test Debt", avatar: "placeholder1", amount: 1000))
    }
}
