//
//  DebtItemView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI


struct PersonsListItemView: View {
    @Environment(\.managedObjectContext) private var viewContext;
    @StateObject var person: Person;
    @State var isDetailsShown = false;
    @State var isAddAmountShown = false;
    
    @State var added: Bool = false;
    @State var addedAmount: Int = 0;
    
    @State var text: String = "";
    
    @State var offset: CGSize = CGSize.zero;
    
    var body: some View {
        if person.avatar == nil {
            EmptyView()
        } else {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            HStack {
                Image(person.avatar!)
                    .resizable()
                    .frame(width: 48, height: 48, alignment: .center)
                    .cornerRadius(24)
                VStack(alignment: .leading, spacing: 4) {
                    Text(person.name!)
                        .fontWeight(.semibold)
                    Text("Amount: $\(person.amount)")
                        .fontWeight(.regular)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.padding(16)
                Spacer()
                Text("+$\(addedAmount)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                    .opacity(added ? 1 : 0)
                    .scaleEffect(added ? 1.2 : 1.0)
                    .rotationEffect(.degrees(added ? 10 : 0))
                    .padding(.trailing, 8)
            }
                .offset(self.offset)
                .onChange(of: added) { value in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation(.spring()) {
                            added = false;
                        }
                    }
                }
                .onTapGesture {
                    isDetailsShown = true;
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            isAddAmountShown = true;
                        } label: {
                            Label("Add", systemImage: "plus")
                        }.tint(.green)
                }
                .sheet(isPresented: $isDetailsShown) {
                    PersonDetailsView(person: person)
                }
                .sheet(isPresented: $isAddAmountShown) {
                    CreateAmountView { amount in
                        isAddAmountShown = false;
                        addedAmount = amount;
                        withAnimation(.spring()) {
                            let newAmount = Amount(context: viewContext);
                            newAmount.amount = Int32(amount);
                            newAmount.timestamp = Date();
                            newAmount.person = person;
                            person.addToAmounts(newAmount);
                            try! viewContext.save();
                            added = true;
                        }
                    }
                }
            }
        }
    }
}
