//
//  GlobalPointPreferenceKey.swift
//  Penjig
//
//  Created by Enes Karaosman on 8.01.2021.
//

import SwiftUI

struct GlobalPointPreferenceKey: PreferenceKey {
    
    static let defaultValue: CGPoint = .zero
 
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

extension View {
    /// Binds center of related view to the `point`.
    func readGlobalPoint(to point: Binding<CGPoint>) -> some View {
        overlay(GeometryReader { gr in
            Color.clear.preference(
                key: GlobalPointPreferenceKey.self,
                value: CGPoint(
                    x: gr.frame(in: .global).origin.x + gr.frame(in: .global).size.width/2,
                    y: gr.frame(in: .global).origin.y + gr.frame(in: .global).size.height/2
                )
            )
        })
        .onPreferenceChange(GlobalPointPreferenceKey.self) {
            point.wrappedValue = $0
        }
    }
}
