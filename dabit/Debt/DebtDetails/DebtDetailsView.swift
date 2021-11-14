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
    @State var isAddModalShow = false;

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
                        Text("$\(debt.amount)")
                            .font(Font.system(size: 64, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .minimumScaleFactor(0.3)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding([.horizontal], 20)
                }.padding()
                
                AmountsList(debt: debt)
                
                Spacer()
                
                VStack() {
                    DButton(title: "Add more", systemIcon: "plus.circle.fill", action: {
                        isAddModalShow = true;
                    })
                }.padding()
            }
            .navigationTitle(debt.title!)
            .sheet(isPresented: $isAddModalShow) {
                CreateAmountView { amount in
                    isAddModalShow = false;
                    withAnimation(.spring()) {
                        viewModel.addNewAmount(debt: debt, amount: Int32(amount));
                    }
                }
            }
        }
    }
}

struct DebtDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtDetailsView(
            debt: {
                let debt = CDDebt()
                debt.title = "Slavik Nychkalo";
                debt.avatar = "placeholder1";
                return debt;
            }()
        )
    }
}
