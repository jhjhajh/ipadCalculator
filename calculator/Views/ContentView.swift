//
//  ContentView.swift
//  calculator
//
//  Created by Jia Hui on 23/3/23.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case.add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }

}
enum Operation {
    case add, subtract, multiply, divide, none
    
    
}
struct ContentView: View {

    @State var value = "0"
    @State var runningNumber : Double = 0.0
    @State var currentOperation: Operation = .none

    let buttons :[[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                //Text Display
                HStack {
                    Spacer()
                      Text(value)
                        .bold()
                        .font(.system(size: 110))
                        .foregroundColor(.white)
                    
                }
                .padding(100)
                // button
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size:72))
                                    .frame(width: self.buttonWidth(item:item), height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item:item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    func didTap(button: CalcButton) {
        switch button {
        case .percent:
            let currentValue = Double(value) ?? 0
            let percentValue = currentValue / 100
            value = String(percentValue)
            runningNumber = percentValue
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                currentOperation = .add
                runningNumber += Double(value) ?? 0
            } else if button == .subtract {
                currentOperation = .subtract
                runningNumber += Double(value) ?? 0
            } else if button == .multiply {
                currentOperation = .multiply
                runningNumber += Double(value) ?? 0
            } else if button == .divide {
                currentOperation = .divide
                runningNumber += Double(value) ?? 0
            } else if button == .equal {
                let currentValue = Double(value) ?? 0
                var result: Double = 0
                switch currentOperation {
                case .add:
                    result = runningNumber + currentValue
                case .subtract:
                    result = runningNumber - currentValue
                case .multiply:
                    result = runningNumber * currentValue
                case .divide:
                    if (currentValue == 0.0) {
                        value = "Math Error"
                        return
                    }
                    result = runningNumber / currentValue
                case .none:
                    result = currentValue
                }
                value = String(result)
                runningNumber = result
            }
            if button != .equal {
                value = "0"
            }
        case .clear:
            value = "0"
            runningNumber = 0
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .negative:
            let currentValue = Double(value) ?? 0
            value = String(currentValue * -1)
            runningNumber = currentValue * -1
        default:
            let number = button.rawValue
            if value == "0" {
                value = number
            } else {
                value += number
            }
        }
    }

//    func didTap(button: CalcButton) {
//        switch button {
//        case .percent:
//            let currentValue = Double(value) ?? 0
//            let percentValue = currentValue / 100
//            value = String(percentValue)
//            runningNumber = percentValue
//            break
//        case .add, .subtract, .multiply, .divide, .equal:
//            if button == .add {
//                self.currentOperation = .add
//                self.runningNumber += Double(self.value) ?? 0
//            }
//            else if button == .subtract {
//                self.currentOperation = .subtract
//                self.runningNumber += Double(self.value) ?? 0
//            }
//            else if button == .multiply {
//                self.currentOperation = .multiply
//                self.runningNumber += Double(self.value) ?? 0
//            }
//            else if button == .divide {
//                self.currentOperation = .divide
//                self.runningNumber += Double(self.value) ?? 0
//            }
//            else if button == .equal {
//
//                let runningValue = self.runningNumber
//                let currentValue = Double(self.value) ?? 0
//
//                switch self.currentOperation {
//                case .add: self.value = "\(runningValue + currentValue)"
//                case .subtract: self.value = "\(runningValue - currentValue)"
//                case .multiply: self.value = "\(runningValue * currentValue)"
//                case .divide:
//                    if (currentValue == 0.0) {
//                        self.value = "Math Error"
//                    }
//                    else {
//                        self.value = "\(runningValue / currentValue)"
//                    }
//                        case .none:
//                    break
//                }
//            }
//            if button != .equal {
//                self.value = "0"
//            }
//        case .clear:
//            self.value = "0"
//            self.runningNumber = 0
//        case .decimal:
//            if !value.contains(".") {
//                self.value += "."
//            }
//            break
//        case .negative:
//            if let doubleValue = Double(self.value) {
//                self.value = "\(doubleValue * -1)"
//                self.runningNumber = doubleValue * -1
//            }
//            break
//
//        default:
//            let number = button.rawValue
//            if self.value == "0" {
//                value = number
//            } else {
//                self.value = "\(self.value)\(number)"
//            }
//        }
//    }
    func buttonWidth(item: CalcButton) -> CGFloat {
        if (item == .zero) {
            return (UIScreen.main.bounds.width - (4*12)) / 5 * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 5
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
