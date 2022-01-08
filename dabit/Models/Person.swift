//
//  CDDebt.swift
//  dabit
//
//  Created by gebeto on 01.09.2021.
//

import Foundation
import SwiftUI


extension Person {
    var amountsArray: [Amount] {
        let set = self.amounts as? Set<Amount> ?? []
        
        return set.sorted(by: { $0.timestamp?.compare($1.timestamp!) == .orderedDescending })
    }
    
    var amount: Int32 {
        return self.amountsArray.filter({ !$0.done }).map({ $0.amount }).reduce(0, +);
    }
}
