//
//  AddView.swift
//  iExpense
//
//  Created by Luis Enrique Rosas Espinoza on 12/02/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = "Add new expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    
    let types = ["Business", "Personal"]
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { typeName in
                        Text(typeName)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "MXN"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button("Save") {
                    if name == "Add new expense" || name.isEmpty {
                        showAlert = true
                        return
                    }
                    
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"), message: Text("You must enter a name for the expense"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
