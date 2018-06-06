import UIKit

class FlightDetailsViewController: UIViewController, StoryboardInstantiable {

    static var storyboardName: String = "FlightDetailsViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SpaceX"
    }
}
