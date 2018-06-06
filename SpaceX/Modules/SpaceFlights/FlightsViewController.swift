import UIKit

final class FlightsViewController: UIViewController, StoryboardInstantiable {

    static var storyboardName: String = "FlightsViewController"
    
    @IBOutlet weak var flightsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItemImage()
        registerCell()
    }
    
    func setNavigationItemImage() {
        
        let spaceXImage = UIImageView(image: #imageLiteral(resourceName: "SpaceX_logo"))
        spaceXImage.contentMode = .scaleAspectFit
        navigationItem.titleView = spaceXImage
    }
    
    func registerCell() {
        flightsTableView.register(UINib(nibName: FlighTableViewCell.identifier, bundle: nil),
                                  forCellReuseIdentifier: FlighTableViewCell.identifier)
    }
}

extension FlightsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flightCell = tableView.dequeueReusableCell(withIdentifier: FlighTableViewCell.identifier, for: indexPath)
        
        return flightCell
    }
}

extension FlightsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let flightDetailsController = FlightDetailsViewController.instantiate()
        navigationController?.pushViewController(flightDetailsController, animated: true)
    }
}
