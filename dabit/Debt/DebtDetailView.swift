//
//  DebtView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct DebtDetailView: View {
    @Environment(\.managedObjectContext) var context;
    let debt: CDDebt;
    
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
                    
                ChumbaView()
                
                Spacer()
                
                VStack {
                    Button(action: {
                        self.context.delete(debt)
                        try? self.context.save();
                    }, label: {
                        Spacer()
                        Label("Close debt", systemImage: "trash.circle.fill")
                            .foregroundColor(.red)
                            .font(.body.bold())
                            .imageScale(.large)
                        Spacer()
                    })
                    .padding()
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.04))
                    .cornerRadius(8)
                }.padding()
            }
            .navigationTitle("More info")
        }
    }
}

struct DebtView_Previews: PreviewProvider {
    static var debt: CDDebt = {
        let debt = CDDebt()
        debt.id = UUID();
        debt.amount = 1000;
        debt.title = "Slavik Nychkalo";
        debt.avatar = "placeholder1";
        return debt;
    }()
    
    static var previews: some View {
        DebtDetailView(debt: debt)
    }
}
