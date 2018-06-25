import Foundation

protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}
