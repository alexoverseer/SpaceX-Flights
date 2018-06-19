import UIKit

extension UIViewController {
    
    func openURL(stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}
