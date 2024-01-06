//
//  SlideViewModel.swift
//  SuperOnboarding
//
//  Created by Anna Ershova on 02.01.2024.
//

import Foundation
import SwiftUI

final class SlideViewModel: ObservableObject {
    @Slides private var data
    @Published var nextSlideText: TextTabModel = .begin
    @Published var backSlideText: TextTabModel = .empty
    @Published var slides: [SlideModel] = SlideData.models
    @Binding var readyToBeClosed: Bool
    private var container: [SlideModel] = []
    
    init(_ readyToBeClosed: Binding<Bool>) {
        self._readyToBeClosed = readyToBeClosed
    }
    
    var close: ((inout Bool) -> ()) = { i in i.toggle() }

    private func pushSlide() {
        guard slides.count < data.count, let slide = container.last else {
            backSlideText = .empty
            nextSlideText = .begin
            return
        }
        slides.append(slide)
        container.removeLast()
        backSlideText = (!container.isEmpty) ? .back : .empty
        nextSlideText = (!container.isEmpty) ? .next : .begin
    }
    
    private func popSlide() {
        guard let slide = slides.last, container.count < data.count, slides.count != 1 else {
            close(&readyToBeClosed)
            return
        }
        container.append(slide)
        slides.removeLast()
        backSlideText = (!container.isEmpty) ? .back : .empty
        nextSlideText = (!container.isEmpty) ? .next : .begin
        nextSlideText = (container.count == data.count - 1) ? .finish : .next
    }
    
    func getSlideWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(slides.count - 1 - id) * 20
        return geometry.size.width - offset
    }
    
    func getSlideOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(slides.count - 1 - id) * 20
    }
        
    func didTap(to value: Int) {
        value == 0 ? pushSlide() : ()
        value == 1 ? popSlide() : ()
    }
    
    func resetAll() {
        nextSlideText = .begin
        backSlideText = .empty
        slides = SlideData.models
        container = []
    }
}
