//
//  BottomRightClipper.swift
//  
//
//  Created by Enes Karaosman on 9.03.2021.
//

import SwiftUI

internal struct BottomRightClipper: Shape {
    let right: CGFloat
    let bottom: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Rectangle().path(in: CGRect(x: 0, y: 0, width: rect.size.width - right, height: rect.size.height - bottom))
    }
}
