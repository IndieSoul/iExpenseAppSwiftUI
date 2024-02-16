//
//  ContentView.swift
//  iExpense
//
//  Created by Luis Enrique Rosas Espinoza on 12/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Personal")) {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            ListCard(item: item)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet)
                    })
                }
                Section(header: Text("Business")) {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            ListCard(item: item)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet)
                    })
                }
            }
            .navigationTitle("iExpense")
            .toolbar(content: {
                ToolbarItem {
                    NavigationLink {
                        AddView(expenses: expenses)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            })
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ListCard: View {
    let item: ExpenseItem
    
    let itemColor: Color
    
    init(item: ExpenseItem) {
        self.item = item
        switch item.amount {
            case 0...10:
                itemColor = .green
            case 11...100:
                itemColor = .yellow
            default:
                itemColor = .red
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            Text(item.amount, format: .currency(code: "MXN"))
                .background(itemColor)
        }
    }
}

#Preview {
    ContentView()
}
