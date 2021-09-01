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
    
    var amounts: [CDAmount] {
        return (debt.amounts as? Set<CDAmount>)?.sorted(by: { $0.createdAt?.compare($1.createdAt!) == .orderedDescending }) ?? []
    }
    
    var summary: Int32 {
        return amounts.map({ $0.amount }).reduce(0, { result, amount in
            result + amount
        })
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(debt.avatar == nil ? "placeholder-default" : debt.avatar!)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                        .padding(.leading, 20)
                    HStack(alignment: .center) {
                        Spacer()
                        Text("$\(summary)")
                            .font(Font.system(size: 64, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .minimumScaleFactor(0.3)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding([.horizontal], 20)
                }.padding()
                
                AmountsList(items: amounts)
                
                Spacer()
                
                VStack() {
                    DButton(title: "Add more", systemIcon: "plus.circle.fill", action: {
                        withAnimation(.spring()) {
                            viewModel.addNewAmount(debt: debt, amount: 123);
                        }
                    })
                }.padding()
            }
            .navigationTitle(debt.title!)
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
