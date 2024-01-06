import SwiftUI
import UIKit

let color1 = Color(hex: 0x373a3a)
let color2 = Color(hex: 0xababab)
let color3Orange = Color(hex: 0xff691b)
let color4LightOrange = Color(hex: 0xf7ac5f)

extension Color {
    public init(hex: UInt32) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8)  & 0xFF) / 255.0
        let blue = CGFloat((hex) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

public struct TextStyle: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(color1)
            .multilineTextAlignment(.center)
            .lineSpacing(5)
    }
}

public struct SubTextStyle: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .foregroundColor(color2)
            .font(.bold(.callout)())
    }
}

public struct RectStyle: ViewModifier {
    public var radius: CGFloat
    
    public init(radius: CGFloat) {
        self.radius = radius
    }
    
    public func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: radius)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1))
            .shadow(color: Color.gray.opacity(0.4), radius: 4)
    }
}

public struct TabStyle: ViewModifier {
    @State private var colorTint: Color
    public var selection: String
    private var value: String

    public init(_ selection: String, _ value: String) {
        self.selection = selection
        self.value = value
        self.colorTint = .white
    }

    public func body(content: Content) -> some View {
        content
            .onChange(of: selection) { oldValue, newValue in
                self.colorTint = (newValue == value) ? .white : color3Orange
            }
            .tint(colorTint)
    }
}

public struct TabItemsStyle: ViewModifier {
    @State private var colorBack: Color
    public var selection: String

    public init(_ selection: String) {
        self.selection = selection
        self.colorBack = color3Orange
    }
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: selection) { newValue in
                self.colorBack = (newValue == "") ? color3Orange : .white
            }
            .toolbarBackground(colorBack, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
}

public struct BannerModifier: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View {
        content
            .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            .onTapGesture {
                withAnimation {
                    
                }
            }
            .animation(.easeInOut)
    }
}
