//
//  ChumbaView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct Colors {
    static var green = Color(red: 0.86, green: 0.96, blue: 0.94, opacity: 1.00)
    static var yellow = Color(red: 1.00, green: 0.96, blue: 0.85, opacity: 1.00)
    static var red = Color(red: 1.00, green: 0.83, blue: 0.85, opacity: 1.00)
}

struct ChumbaView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .top, spacing: 20) {
                ForEach(1..<4) { item in
                    HStack {
                        VStack(alignment: .leading, content: {
                            Text("Debt \(item)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("$\(100)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        })
                        Spacer()
                    }
                    .padding()
                    .padding(.leading, 10)
                    .padding(.top, 10)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 200)
                    .background(Colors.green)
                    .cornerRadius(16)
                    .layoutPriority(0)
                }
            }.padding()
        })
    }
}

struct ChumbaView_Previews: PreviewProvider {
    static var previews: some View {
        ChumbaView()
            .previewLayout(.sizeThatFits)
    }
}
