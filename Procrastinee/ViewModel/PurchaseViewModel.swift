//
//  PurchaseViewModel.swift
//  Procrastinee
//
//  Created by Macostik on 22.12.2022.
//

import Foundation

class PurchaseViewModel: ObservableObject {
    @Published var selectPurchase: PurchaseType = .none
    @Published var purchaseList = [
         Purchase(purchaseType: .week),
         Purchase(purchaseType: .month),
         Purchase(purchaseType: .year)
     ]
}
