//
//  DebtItemView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI


struct DebtsListItemView: View {
    let viewModel = DebtDetailsViewModel();
    @StateObject var debt: CDDebt;
    @State var isDetailsShown = false;
    @State var isAddAmountShown = false;
    
    @State var added: Bool = false;
    
    var body: some View {
        if debt.avatar == nil {
            EmptyView()
        } else {
            HStack {
                Image(debt.avatar!)
                    .resizable()
                    .frame(width: 48, height: 48, alignment: .center)
                    .cornerRadius(24)
                VStack(alignment: .leading, spacing: 4) {
                    Text(debt.title!)
                        .fontWeight(.semibold)
                    Text("Amount: $\(debt.amount)")
                        .fontWeight(.regular)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(16)
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
                    .opacity(added ? 1 : 0)
                    .scaleEffect(added ? 1.2 : 1.0)
                    .rotationEffect(.degrees(added ? 10 : 0))
            }
            .onChange(of: added, perform: { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.spring()) {
                        added = false;
                    }
                }
            })
            .onTapGesture(perform: {
                isDetailsShown = true;
            })
            .onLongPressGesture {
                isAddAmountShown = true;
            }
            .sheet(isPresented: $isDetailsShown, content: {
                DebtDetailsView(debt: debt)
            })
            .sheet(isPresented: $isAddAmountShown, content: {
                CreateAmountView { amount in
                    isAddAmountShown = false;
                    withAnimation(.spring()) {
                        viewModel.addNewAmount(debt: debt, amount: Int32(amount));
                        added = true;
                    }
                }
            })
        }
    }
}


struct DebtItemView_Previews: PreviewProvider {
    static var previews: some View {
        DebtsListItemView(
            debt: {
                let debt = CDDebt()
                debt.title = "Test Debt";
                debt.avatar = "placeholder1";
                return debt;
            }()
        )
        .previewLayout(.sizeThatFits)
    }
}
