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
        VStack(alignment: .center) {
            Image(debt.avatar)
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(100)
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Text(debt.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            Text("$\(debt.amount)")
                .font(.title2)
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .padding(.bottom, 30)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(1..<4) { item in
                        VStack(alignment: .leading) {
                            Text("Hello \(item)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("$\(100)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.red, Color.red, Color.red, Color.orange]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(16)
                    }
                }.padding()
            }
            
            Spacer()
            
            Button(action: {
                print("Close debt")
            }, label: {
                Spacer()
                Label("Close debt", systemImage: "trash")
                Spacer()
            })
            .padding()
            .background(Color(red: 0, green: 0, blue: 0, opacity: 0.04))
            .cornerRadius(8)
        }.padding()
    }
}

struct DebtView_Previews: PreviewProvider {
    static var previews: some View {
        DebtDetailView(debt: DebtItem(title: "Slavik Nychkalo", avatar: "placeholder2", amount: 1000))
    }
}
