import Foundation
import UIKit

extension UINavigationController {
    
    func setDarkAppearance() {    
        self.navigationBar.barTintColor = UIColor.appGray
        self.navigationBar.tintColor = UIColor.white
        
        let lightAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = lightAttributes
    }
}
