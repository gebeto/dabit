//
//  DebtView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct DebtDetailView: View {
    let debt: DebtItem;
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(debt.avatar)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                    
                    VStack(alignment: .leading) {
                        Text(debt.title)
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
                        print("Close debt")
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
    static var previews: some View {
        DebtDetailView(debt: DebtItem(title: "Slavik Nychkalo", avatar: "placeholder2", amount: 1000))
    }
}
