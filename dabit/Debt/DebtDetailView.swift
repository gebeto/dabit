//
//  DebtView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct DebtDetailView: View {
    @StateObject var debt: CDDebt;
    var addNewAmount: (CDDebt) -> Void;
    
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
                
                if let allAmounts = debt.amounts?.allObjects as? [CDAmount] {
                    AmountsList(items: allAmounts)
                }
                
                Spacer()
                
                VStack() {
                    DButton(title: "Add more", systemIcon: "plus.circle.fill", action: {
                        print("Add more hello")
                        self.addNewAmount(debt);
                    })
                }.padding()
            }
            .navigationTitle("More info")
        }
    }
}

struct DebtView_Previews: PreviewProvider {
    static var previews: some View {
        DebtDetailView(
            debt: {
                let debt = CDDebt()
                debt.id = UUID();
                debt.amount = 1000;
                debt.title = "Slavik Nychkalo";
                debt.avatar = "placeholder1";
                return debt;
            }(),
            addNewAmount: { debt in
                
            }
        )
    }
}
