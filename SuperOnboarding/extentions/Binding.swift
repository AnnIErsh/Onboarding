//
//  Binding.swift
//  SuperOnboarding
//
//  Created by Anna Ershova on 04.01.2024.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(get: { self.wrappedValue }, set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
