//
//  DebtItemView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI


struct PersonsListItemView: View {
    @Environment(\.managedObjectContext) private var viewContext;
    @StateObject var person: CDPerson;
    @State var isDetailsShown = false;
    @State var isAddAmountShown = false;
    
    @State var added: Bool = false;
    @State var addedAmount: Int = 0;
    
    @State var text: String = "";
    
    @State var offset: CGSize = CGSize.zero;
    
    var degrees: Double {
        if offset.animatableData.first > 45 {
            return 90
        }
        return Double(offset.animatableData.first * 2)
    }
    
    var scale: CGFloat {
        return offset.animatableData.first > 0 ? offset.animatableData.first * 0.016 : 0
    }
    
    var offsetLeft: CGFloat {
        let half = offset.animatableData.first / 4;
        return half - half / 2;
    }
    
    var body: some View {
        if person.avatar == nil {
            EmptyView()
        } else {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                Image(systemName: "plus.circle.fill")
                .font(.system(size: 24))
                .foregroundColor(.green)
                .scaleEffect(self.scale)
                .rotationEffect(.degrees(Double(degrees)))
                .offset(x: offsetLeft)
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
            .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                Button {
                    isAddAmountShown = true;
                } label: {
                    Label("Add", systemImage: "plus")
                }.tint(.green)
            })
            .sheet(isPresented: $isDetailsShown, content: {
                PersonDetailsView(person: person)
            })
            .sheet(isPresented: $isAddAmountShown, content: {
                CreateAmountView { amount in
                    isAddAmountShown = false;
                    addedAmount = amount;
                    withAnimation(.spring()) {
                        let newAmount = CDAmount(context: viewContext);
                        newAmount.amount = Int32(amount);
                        newAmount.timestamp = Date();
                        newAmount.person = person;
                        person.addToAmounts(newAmount);
                        try! viewContext.save();
                        added = true;
                    }
                }
            })
            })
        }
    }
}


struct DebtItemView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsListItemView(
            person: {
                let person = CDPerson()
                person.name = "Test Debt";
                person.avatar = "placeholder1";
                return person;
            }()
        )
        .previewLayout(.sizeThatFits)
    }
}
