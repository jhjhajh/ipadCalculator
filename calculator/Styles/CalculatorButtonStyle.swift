import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {
    
    var width: CGFloat
    var height: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: 60, weight: .medium))
                .frame(width: width, height: height)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .overlay {
                    if configuration.isPressed {
                        Color(white: 1.0, opacity: 0.2)
                    }
                }
                .clipShape(Capsule())
    }
}
