//
//  CreateAmountView.swift
//  dabit
//
//  Created by gebeto on 29.08.2021.
//

import SwiftUI

struct KeyboardButton: View {
    let title: String;
    let action: () -> Void;
    
    var body: some View {
        Button(action: action, label: {
            Spacer()
            VStack {
                Spacer()
                Text(title)
                Spacer()
            }
            Spacer()
        })
        .font(.system(size: 21, weight: .bold, design: .rounded))
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.04))
        .foregroundColor(.black)
        .cornerRadius(6)
    }
}

struct CreateAmountView: View {
    let onAdd: (Int) -> Void;
    
    @State var valueArray: [Int] = [];
    
    func pushItem(item: Int) {
        if valueArray.count < 7 {
            valueArray.append(item);
        }
    }
    
    func popItem() {
        if valueArray.count > 0 {
            valueArray.removeLast();
        }
    }
    
    func toJoined(items: [Int]) -> Int {
        let joined = items.map{ String($0) }.joined()
        let value = Int(joined);
        return value == nil ? 0 : value!;
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("$\(toJoined(items: valueArray))")
                    .font(.system(size: 64, weight: .semibold, design: .rounded))
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    KeyboardButton(title: "1", action: {pushItem(item: 1)})
                    KeyboardButton(title: "2", action: {pushItem(item: 2)})
                    KeyboardButton(title: "3", action: {pushItem(item: 3)})
                }
                HStack(spacing: 8) {
                    KeyboardButton(title: "4", action: {pushItem(item: 4)})
                    KeyboardButton(title: "5", action: {pushItem(item: 5)})
                    KeyboardButton(title: "6", action: {pushItem(item: 6)})
                }
                HStack(spacing: 8) {
                    KeyboardButton(title: "7", action: {pushItem(item: 7)})
                    KeyboardButton(title: "8", action: {pushItem(item: 8)})
                    KeyboardButton(title: "9", action: {pushItem(item: 9)})
                }
                HStack(spacing: 8) {
                    KeyboardButton(title: "⌫", action: {popItem()})
                    KeyboardButton(title: "0", action: {pushItem(item: 0)})
                    KeyboardButton(title: "Add", action: {
                        onAdd(toJoined(items: valueArray));
                    })
                }
            }
            .padding(8)
            .frame(maxHeight: UIScreen.main.bounds.height / 3)
        }
    }
}

struct CreateAmountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAmountView(onAdd: { amount in
            print(amount)
        })
    }
}
