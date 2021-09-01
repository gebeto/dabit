//
//  DebtDetailsViewModel.swift
//  dabit
//
//  Created by gebeto on 01.09.2021.
//

import Foundation
import CoreData


class DebtDetailsViewModel: ObservableObject {
    private var persistance = PersistenceController.shared;
    
    func addNewAmount(debt: CDDebt, amount: Int32) {
        let newAmount = CDAmount(context: persistance.container.viewContext);
        newAmount.amount = amount;
        newAmount.createdAt = Date();
        newAmount.debt = debt;
        debt.addToAmounts(newAmount);
        persistance.save();
    }
}

