import UIKit


protocol StoryboardInstantiable: class {
    static var storyboardName: String { get }
    static var identifier: String { get }
    static func instantiate() -> Self
}

extension StoryboardInstantiable {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: Self.storyboardName, bundle: nil)
    }
    
    /// Instantiates view controller with the specified identifier.
    /// Unless specified it will take the **identifier** as the class name.
    static func instantiate() -> Self {
        return storyboard.instantiateViewController(withIdentifier: identifier) !! "Could not instantiate \(Self.self) from storyboard file."
    }
}
