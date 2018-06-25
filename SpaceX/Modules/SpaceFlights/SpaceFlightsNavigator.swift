import UIKit

class SpaceFlightsNavigator: Navigator {
    
    enum Destination {
        case flightDetails(details: Flight)
    }
    
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializer
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigator
    
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        
        switch destination {
        case .flightDetails(let flight):
            let flightDetailsController = FlightDetailsViewController.instantiate()
            flightDetailsController.setupFlight(flight)
            return flightDetailsController
        }
    }
}
