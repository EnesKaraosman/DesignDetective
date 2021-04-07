//
//  Extensions.swift
//  
//
//  Created by Enes Karaosman on 10.03.2021.
//

import UIKit
import SwiftUI

internal extension UIWindow {
    static func getTopViewController(
        _ forWindow: UIWindow? = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    ) -> UIViewController? {
        
        if var topController = forWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return nil
    }
}

/// Preview Views
internal struct PreviewView<ViewType: UIView>: UIViewRepresentable {
    
    private let `for`: ViewType
    public init(for view: ViewType) {
        self.`for` = view
    }
    
    public func makeUIView(context: Context) -> ViewType {
        `for`
    }
    
    public func updateUIView(_ uiView: ViewType, context: Context) {
        
    }
    
}
