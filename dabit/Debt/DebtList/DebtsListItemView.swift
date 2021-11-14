//
//  DebtItemView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI


struct DebtsListItemView: View {
    let viewModel = DebtDetailsViewModel();
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
            .gesture(
                DragGesture(minimumDistance: 1.0)
                    .onChanged({ drag in
                        let curr = drag.translation.width;
                        let tension = curr * 0.7;
                        let res = curr - tension
                        if res <= 0 {
                            offset = CGSize.zero;
                        } else if res > 0 {
                            offset = CGSize(width: res, height: 0);
                        }
                    })
                    .onEnded({ drag in
                        withAnimation(.spring()) {
                            if drag.translation.width > 80 {
                                isAddAmountShown = true;
                            }
                            offset = CGSize.zero
                        }
                    })
            )
            .sheet(isPresented: $isDetailsShown, content: {
                DebtDetailsView(person: person)
            })
            .sheet(isPresented: $isAddAmountShown, content: {
                CreateAmountView { amount in
                    isAddAmountShown = false;
                    addedAmount = amount;
                    withAnimation(.spring()) {
                        viewModel.addNewAmount(person: person, amount: Int32(amount));
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
        DebtsListItemView(
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
