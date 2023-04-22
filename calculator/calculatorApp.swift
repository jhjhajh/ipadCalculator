//
//  calculatorApp.swift
//  calculator
//
//  Created by Jia Hui on 23/3/23.
//


import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(CalculatorView.ViewModel())
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CalculatorView.ViewModel()
        return CalculatorView()
            .environmentObject(viewModel)
    }
}
