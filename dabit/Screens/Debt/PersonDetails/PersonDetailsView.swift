//
//  DebtView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct PersonDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext;
    @StateObject var person: Person;
    @State var isAddModalShow = false;

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(person.avatar == nil ? "placeholder-default" : person.avatar!)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                        .padding(.leading, 20)
                    HStack(alignment: .center) {
                        Spacer()
                        Text("$\(person.amount)")
                            .font(Font.system(size: 64, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .minimumScaleFactor(0.3)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding([.horizontal], 20)
                }.padding()
                
                AmountsList(person: person)
                
                Spacer()

                CreateAmountView { amount in
                    withAnimation(.spring()) {
                        let newAmount = Amount(context: viewContext);
                        newAmount.amount = Int32(amount);
                        newAmount.timestamp = Date();
                        newAmount.person = person;
                        person.addToAmounts(newAmount);
                        try! viewContext.save();
                    }
                }
            }
            .navigationTitle(person.name!)
        }
    }
}
