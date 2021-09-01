//
//  DebtView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    let viewModel = DebtDetailsViewModel();
    @StateObject var debt: CDDebt;
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(debt.avatar == nil ? "placeholder-default" : debt.avatar!)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                    
                    VStack(alignment: .leading) {
                        Text(debt.title == nil ? "Unknown" : debt.title!)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("$\(debt.amount)")
                            .font(.title2)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                    }
                    .padding(.leading, 10)
                }.padding()
                
                if let allAmounts = (debt.amounts as? Set<CDAmount>)?.sorted(by: { $0.createdAt?.compare($1.createdAt!) == .orderedDescending }) {
                    AmountsList(items: allAmounts)
                }
                
                Spacer()
                
                VStack() {
                    DButton(title: "Add more", systemIcon: "plus.circle.fill", action: {
                        withAnimation(.spring()) {
                            viewModel.addNewAmount(debt: debt, amount: 123);
                        }
                    })
                }.padding()
            }
            .navigationTitle("More info")
        }
    }
}

struct DebtDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtDetailsView(
            debt: {
                let debt = CDDebt()
                debt.amount = 1000;
                debt.title = "Slavik Nychkalo";
                debt.avatar = "placeholder1";
                return debt;
            }()
        )
    }
}
