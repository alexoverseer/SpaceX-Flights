import UIKit

final class FlightsViewController: UIViewController, StoryboardInstantiable {

    static var storyboardName: String = "FlightsViewController"
    
    private var spaceFlights: [Flight]?
    
    @IBOutlet weak var flightsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItemImage()
        registerCell()
        getSpaceFlights()
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
    
    func getSpaceFlights() {
        
        SpaceFlights().requestFlights(onSuccess: { [weak self] flights in
            self?.spaceFlights = flights
            self?.spaceFlights?.reverse()
            self?.flightsTableView.reloadData()
        }) { [weak self] error in
            let alert = UIAlertController(info: AlertInfo(title: "Error", message: error.message))
            self?.present(alert, animated: true)
        }
    }
}

extension FlightsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.spaceFlights?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flightCell = tableView.dequeueReusableCell(withIdentifier: FlighTableViewCell.identifier, for: indexPath) as! FlighTableViewCell
        flightCell.setupCell(flight: self.spaceFlights![indexPath.row])
        
        return flightCell
    }
}

extension FlightsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let flightDetailsController = FlightDetailsViewController.instantiate()
        navigationController?.pushViewController(flightDetailsController, animated: true)
    }
}
