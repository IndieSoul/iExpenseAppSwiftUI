//
//  User.swift
//  iExpense
//
//  Created by Luis Enrique Rosas Espinoza on 12/02/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
