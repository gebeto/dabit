//
//  DebtsListViewModel.swift
//  dabit
//
//  Created by gebeto on 31.08.2021.
//

import Foundation
import CoreData


class DebtsListViewModel: ObservableObject {
    private var container: PersistenceController = PersistenceController.shared;
    private var viewContext: NSManagedObjectContext = PersistenceController.viewContext;
    @Published var debts: [CDDebt] = [];
    
    func saveAndFetch() {
        try? viewContext.save();
        fetchItems();
    }
    
    func fetchItems() {
        container.fetchDebts { debts in
            self.debts = debts;
        }
    }
    
    func addItem(title: String, amount: Int32, avatar: String) {
        let debt = CDDebt(context: viewContext);
        debt.amount = amount;
        debt.avatar = avatar;
        debt.title = title;
        saveAndFetch();
    }
    
    func deleteItems(indexSet: IndexSet) {
        indexSet.map{ debts[$0] }.forEach(self.deleteItem)
        saveAndFetch();
    }
    
    private func deleteItem(debt: CDDebt) {
        viewContext.delete(debt);
    }
    
}
