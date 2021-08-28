//
//  DebtItem.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//

import Foundation


struct DebtItem {
    var title: String;
    var avatar: String;
    var amount: Int32;
    
    init(title: String, avatar: String, amount: Int32) {
        self.title = title;
        self.avatar = avatar;
        self.amount = amount;
    }
    
    init(debt: CDDebt) {
        self.title = debt.title!;
        self.avatar = debt.avatar!;
        self.amount = debt.amount;
    }
}
