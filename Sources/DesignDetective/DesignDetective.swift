import SwiftUI

public enum DetectiveError: Error {
    case couldNotCaptureScreen
}

public class DesignDetective {
    
    public static let shared = DesignDetective()
    
    private(set) public var isActive = false
    
    private var window: UIWindow?
    
    public func activate() throws {
        if let vc = UIWindow.getTopViewController() {
            let targetView = vc.view!
            guard let snapshot = targetView.makeSnapshot() else {
                throw DetectiveError.couldNotCaptureScreen
            }
            let swiftUIView = DesignDetectiveView(backImage: snapshot)
            let swiftUIHostVC = UIHostingController(rootView: swiftUIView)
            swiftUIHostVC.modalPresentationStyle = .fullScreen
            vc.present(swiftUIHostVC, animated: true) {
                self.isActive = true
                print("DetectiveView activated")
            }
        }
    }
    
    public func deActivate() {
        if let vc = UIWindow.getTopViewController() {
            vc.dismiss(animated: true) {
                self.isActive = false
                print("DetectiveView deActivated")
            }
        }
    }
    
}

internal class DesignDetectiveViewModel: ObservableObject {
    
    static let shared = DesignDetectiveViewModel()
    
    @Published var image: UIImage?
    
    func getImagefromURL(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
}
