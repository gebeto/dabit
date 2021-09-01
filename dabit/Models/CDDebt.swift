//
//  CDDebt.swift
//  dabit
//
//  Created by gebeto on 01.09.2021.
//

import Foundation


extension CDDebt {
    var amount: Int32 {
        let amounts = (self.amounts as? Set<CDAmount>)?.sorted(by: { $0.createdAt?.compare($1.createdAt!) == .orderedDescending }) ?? [];
        return amounts.map({ $0.amount }).reduce(0, +);
    }
    
    var amountsArray: [CDAmount] {
        return (self.amounts as? Set<CDAmount>)?.sorted(by: { $0.createdAt?.compare($1.createdAt!) == .orderedDescending }) ?? []
    }
}
