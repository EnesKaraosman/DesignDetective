//
//  ButtomRightCursor.swift
//  
//
//  Created by Enes Karaosman on 9.03.2021.
//

import SwiftUI

internal struct BottomRightCursor: View {
    
    @State private var dragAmount = CGSize.zero
    @State private var globalLocation: CGPoint = .zero
    
    var onChanged: ((CGPoint) -> Void)?
    var onEnded: ((CGPoint) -> Void)?
    
    var body: some View {
        Image(systemName: "cursorarrow.motionlines.click")
            .resizable()
            .scaledToFit()
            .frame(width: 40)
            .foregroundColor(.purple)
            .shadow(radius: 2)
            .readGlobalPoint(to: $globalLocation)
            .offset(dragAmount)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        dragAmount = CGSize(
                            width: $0.translation.width,
                            height: $0.translation.height
                        )
                        onChanged?(globalLocation)
                    }
                    .onEnded { value in
                        onEnded?(globalLocation)
                        globalLocation = .zero
                        dragAmount = .zero
                    }
            )
    }
}

