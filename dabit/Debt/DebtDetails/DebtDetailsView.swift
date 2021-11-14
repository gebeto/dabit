//
//  DebtView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct DebtDetailsView: View {
    let viewModel = DebtDetailsViewModel();
    @StateObject var person: CDPerson;
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
                
                VStack() {
                    DButton(title: "Add more", systemIcon: "plus.circle.fill", action: {
                        isAddModalShow = true;
                    })
                }.padding()
            }
            .navigationTitle(person.name!)
            .sheet(isPresented: $isAddModalShow) {
                CreateAmountView { amount in
                    isAddModalShow = false;
                    withAnimation(.spring()) {
                        viewModel.addNewAmount(person: person, amount: Int32(amount));
                    }
                }
            }
        }
    }
}

struct DebtDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DebtDetailsView(
            person: {
                let person = CDPerson()
                person.name = "Slavik Nychkalo";
                person.avatar = "placeholder1";
                return person;
            }()
        )
    }
}
