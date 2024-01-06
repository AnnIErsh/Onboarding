//
//  OnboardScreen.swift
//  SuperOnboarding
//
//  Created by Anna Ershova on 31.12.2023.
//

import SwiftUI
import UI

struct OnboardScreen: View {
    @ObservedObject var slideViewModel: SlideViewModel
    @State var selection: Int = 1
    @Binding var isPresented: Bool
    
    init(_ isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        slideViewModel = SlideViewModel(isPresented)
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection.onChange(slideViewModel.didTap)) {
                Group {
                    Text("BEGIN")
                        .tabItem {
                            Text("\(slideViewModel.backSlideText.rawValue)")
                        }
                        .tag(0)
                    Text("END")
                        .tabItem {
                            Text("\(slideViewModel.nextSlideText.rawValue)")
                        }
                        .tag(1)
                }
                .modifier(TabItemsStyle(slideViewModel.backSlideText.rawValue))
            }
            .modifier(TabStyle(slideViewModel.nextSlideText.rawValue, TextTabModel.begin.rawValue))
            slides
                .padding(20)
                .offset(y: 100)
        }
        .onAppear {
            slideViewModel.resetAll()
        }
        .ignoresSafeArea()
    }
    
    var slides: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(slideViewModel.slides.indices, id: \.self) { i in
                    ZStack {
                        rect
                            .modifier(BannerModifier())
                        VStack {
                            Image("\(slideViewModel.slides[i].picture)")
                                .resizable()
                                .scaledToFit()
                                .padding()
                            Text("\(slideViewModel.slides[i].text)")
                                .modifier(TextStyle())
                            Spacer()
                            Text("\(slideViewModel.slides[i].subtext)")
                                .modifier(SubTextStyle())
                        }
                        .padding()
                        .modifier(BannerModifier())
                    }
                    .frame(width: slideViewModel.getSlideWidth(geometry, id: i), height: geometry.size.height / 1.4)
                    .offset(x: 0, y: slideViewModel.getSlideOffset(geometry, id: i))
                }
            }
        }
    }
    
    var rect: some View {
        RoundedRectangle(cornerRadius: 4)
            .modifier(RectStyle(radius: 4))
    }
}
