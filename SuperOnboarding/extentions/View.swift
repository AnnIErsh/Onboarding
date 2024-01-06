//
//  View.swift
//  SuperOnboarding
//
//  Created by Anna Ershova on 31.12.2023.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

extension View {
    var lazy: some View {
        LazyView(self)
    }
    
    func toAnyView() -> AnyView {
        AnyView(self)
    }
    
    @ViewBuilder
    func showSlides(isPresented: Binding<Bool>, screen: @escaping () -> AnyView) -> some View {
        fullScreenCover(isPresented: isPresented, content: screen)
    }
}
