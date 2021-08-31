//
//  DebtsListViewModel.swift
//  dabit
//
//  Created by gebeto on 31.08.2021.
//

import Foundation
import CoreData


class DebtsListViewModel: ObservableObject {
    private var container: NSPersistentContainer = PersistenceController.shared.container;
    @Published var debts: [CDDebt] = [];
    
    func saveAndFetch() {
        try? container.viewContext.save();
        fetchItems();
    }
    
    func fetchItems() {
        let request = NSFetchRequest<CDDebt>(entityName: CDDebt.entity().name!);
        do {
            self.debts = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)");
        }
    }
    
    func addItem(title: String, amount: Int32, avatar: String) {
        let debt = CDDebt(context: container.viewContext);
        debt.id = UUID();
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
        container.viewContext.delete(debt);
    }
    
}
