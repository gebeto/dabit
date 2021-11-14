//
//  CDDebt.swift
//  dabit
//
//  Created by gebeto on 01.09.2021.
//

import Foundation


extension CDPerson {
    var amount: Int32 {
        let amounts = (self.amounts as? Set<CDAmount>)?.sorted(by: { $0.timestamp?.compare($1.timestamp!) == .orderedDescending }) ?? [];
        return amounts.map({ $0.amount }).reduce(0, +);
    }
    
    var amountsArray: [CDAmount] {
        return (self.amounts as? Set<CDAmount>)?.sorted(by: { $0.timestamp?.compare($1.timestamp!) == .orderedDescending }) ?? []
    }
}
