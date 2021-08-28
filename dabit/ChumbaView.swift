//
//  ChumbaView.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import SwiftUI

struct ChumbaView: View {
    var body: some View {
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
    }
}

struct ChumbaView_Previews: PreviewProvider {
    static var previews: some View {
        ChumbaView()
            .previewLayout(.sizeThatFits)
    }
}
