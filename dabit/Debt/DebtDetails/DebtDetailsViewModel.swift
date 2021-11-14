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
    
    func addNewAmount(person: CDPerson, amount: Int32) {
        let newAmount = CDAmount(context: persistance.container.viewContext);
        newAmount.amount = amount;
        newAmount.timestamp = Date();
        newAmount.person = person;
        person.addToAmounts(newAmount);
        persistance.save();
    }
}

