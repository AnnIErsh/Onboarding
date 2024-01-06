//
//  MainScreen.swift
//  SuperOnboarding
//
//  Created by Anna Ershova on 30.12.2023.
//

import SwiftUI

struct MainScreen: View {
    @State var isPresented: Bool = false

    var body: some View {
        VStack {
            Button("Start") {
                isPresented.toggle()
            }
            .showSlides(isPresented: $isPresented, screen: OnboardScreen($isPresented).lazy.toAnyView)
        }
        .padding()
    }
}
