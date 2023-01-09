//
//  PurchaseModel.swift
//  Procrastinee
//
//  Created by Macostik on 22.12.2022.
//

import Foundation

struct Purchase: Identifiable, Hashable {
    var id = UUID()
    var purchaseType: PurchaseType
}

enum PurchaseType: String, CaseIterable {
    case none, week, month, year
    var description: String {
        switch self {
        case .none: return ""
        case .week: return L10n.Onboarding.oneWeek
        case .month: return L10n.Onboarding.threeMonth
        case .year: return L10n.Onboarding.oneYear
        }
    }
    var price: String {
        switch self {
        case .none: return ""
        case .week: return L10n.Onboarding.oneWeekPrice
        case .month: return L10n.Onboarding.threeMonthPrice
        case .year: return L10n.Onboarding.oneYearPrice
        }
    }
    var averageValue: String {
        switch self {
        case .none: return ""
        case .week: return L10n.Onboarding.averagePriceOfWeek
        case .month: return L10n.Onboarding.averagePriceOfMonth
        case .year: return L10n.Onboarding.averagePriceOfYear
        }
    }
}
