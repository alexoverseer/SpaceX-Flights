import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        let red = interval(0, r, 255)
        let green = interval(0, g, 255)
        let blue = interval(0, b, 255)
        let alpha = interval(0, a, 1)
        
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static var appGray: UIColor {
        return UIColor(r: 30, g: 29, b: 37)
    }
}
