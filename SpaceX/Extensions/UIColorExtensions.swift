import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        let red = interval(0, r, 255)
        let green = interval(0, g, 255)
        let blue = interval(0, b, 255)
        let alpha = interval(0, a, 1)
        
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static var appBlue: UIColor {
        return UIColor(r: 3, g: 36, b: 63)
    }

    static var appGray: UIColor {
        return UIColor(r: 34, g: 33, b: 41)
    }
}
