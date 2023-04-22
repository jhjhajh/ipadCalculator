//
//  CalculatorButton.swift
//  calculator
//
//  Created by Jia Hui on 22/4/23.
//

import SwiftUI

extension CalculatorView {
    struct CalculatorButton: View {
        
        let buttonType: ButtonType
        
        var body: some View {
            Button(buttonType.description) { }
                .buttonStyle(CalculatorButtonStyle(
                    width: buttonWidth(buttonType: buttonType),
                    height: buttonHeight(),
                    backgroundColor: buttonType.backgroundColor,
                    foregroundColor: buttonType.foregroundColor
                    )
                )
        }
        
        private func buttonWidth(buttonType: ButtonType) -> CGFloat {
            if (buttonType == .digit(.zero)) {
                return (UIScreen.main.bounds.width - (4*12)) / 5 * 2
            }
            return (UIScreen.main.bounds.width - (5*12)) / 5
        }
        
        func buttonHeight() -> CGFloat {
            return (UIScreen.main.bounds.width - (5*12)) / 5
        }
    }
}
