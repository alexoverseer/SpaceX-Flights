import UIKit

extension UIViewController {
    
    func openURL(stringURL: String) {
        let url = URL(string: stringURL)
        if let url = url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
